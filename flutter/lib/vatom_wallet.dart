import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'vatom_classes.dart';
import 'vatom_location_handler.dart';
import 'vatom_message_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:device_info_plus/device_info_plus.dart';

// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:permission_handler/permission_handler.dart';

String routeKey = "route";

// ignore: must_be_immutable
class VatomWallet extends StatelessWidget with WidgetsBindingObserver {
  late WebViewController _controller;
  final _vatomLocationHandler = VatomLocationHandler();
  final VatomMessageHandler _vatomMessageHandler = VatomMessageHandler();
  final tabsRoutesAllowed = ['Home', 'Wallet', 'Map', 'MapAr', 'Connect'];
  final Widget? title;
  late String? accessToken;
  final String? businessId;
  late String? initialRoute;
  final VatomConfigFeatures? config;
  late String? refreshToken;
  final Function? onInventoryUpdate;
  final Function? onCustomActionReceived;
  final Function? onMessageReceived;
  var loaded = false;
  var started = false;
  var isLoadedToWork = false;
  final Map<String, Function> _messageHandlersWebView = {};

  VatomWallet(
      {super.key,
      this.title,
      this.accessToken,
      this.businessId,
      this.config,
      this.refreshToken,
      this.initialRoute,
      this.onInventoryUpdate,
      this.onCustomActionReceived,
      this.onMessageReceived}) {
    initState();
    WidgetsBinding.instance.addObserver(this);
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) async {
  //   if (state == AppLifecycleState.paused) {
  //     String? url = await _controller.currentUrl();
  //     //validate that the url is not null
  //     // ignore: unnecessary_null_comparison
  //     if (url != null) _setCurrentUrl(url);

  //     return;
  //   }

  //   print("Bahia didChangeAppLifecycleState $state  _setCurrentUrl(" ");");
  //   _setCurrentUrl("");
  // }

  void on(String msg, Function handler) {
    print("on $msg");
    _messageHandlersWebView[msg] = handler;
  }

  Future<void> handleCameraPermissions(WebViewPermissionRequest request) async {
    bool isCameraGranted = await Permission.camera.isGranted;
    if (!isCameraGranted) {
      // Ask for permission
      if (await Permission.camera.request().isGranted == false) {
        // Permission denied
        request.deny();
      } else {
        request.grant();
      }
    } else {
      request.grant();
    }
  }

  void initState() async {
    late final PlatformWebViewControllerCreationParams params;

    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    _controller = WebViewController.fromPlatformCreationParams(params,
        onPermissionRequest: (request) {
      if (request.types.contains(WebViewPermissionResourceType.camera)) {
        handleCameraPermissions(request);
      }
    })
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          // onProgress: (int progress) {
          //   print("CONSOLE progress: $progress");
          // },
          // onPageStarted: (String url) {
          //   initSDK();
          // },
          // onPageFinished: (String url) {
          //   if (!loaded) {
          //     setLoaded(true);
          //   }
          // },
          onWebResourceError: (WebResourceError error) {
            print(error.description);
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.isMainFrame &&
                !request.url.contains("vatom") &&
                !request.url.contains("ngrok") &&
                !request.url.contains("localhost") &&
                !request.url.contains("192.168.0.10") &&
                !request.url.contains("https://www.google.com/recaptcha")) {
              launchUrl(Uri.parse(request.url));
            }
            if (request.url.contains("geo:")) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel('vatomMessageHandler',
          onMessageReceived: (JavaScriptMessage message) {
        dynamic data = _vatomMessageHandler.decodeMessage(message);
        final name = data?.name;

        final payload = data?.payload;

        if (name == "walletsdk:analytics") {
          if (payload is Map) {
            final eventName = payload["name"];

            print("walletsdk:analytics: $eventName");
            print(
                "walletsdk:analytics:  payload[payload] ${payload["payload"]}");

            if (_messageHandlersWebView.containsKey(eventName)) {
              _messageHandlersWebView[eventName]!(
                {
                  "token": payload["token"] ?? {},
                  "payload": payload["payload"] ?? {},
                },
              ); // Call the handler with the payload
            }
          }
        } else {
          _vatomMessageHandler.onMessage(message);
        }
      });

    // Debugg ios
    if (_controller.platform is WebKitWebViewController && kDebugMode) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      deviceInfo.iosInfo.then((iosInfo) {
        var version = iosInfo.systemVersion.split(".");
        var versionNumber = double.parse("${version[0]}.${version[1]}");
        if (versionNumber > 16.4) {
          (_controller.platform as WebKitWebViewController)
              .setInspectable(true);
        }
      });
    }
    // android debug and permissions
    if (_controller.platform is AndroidWebViewController) {
      if (kDebugMode) {
        AndroidWebViewController.enableDebugging(true);
      }
      (_controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
      (_controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
      (_controller.platform as AndroidWebViewController)
          .setGeolocationPermissionsPromptCallbacks(
              onShowPrompt: (_vatomLocationHandler.handleAndroidPermission));
    }

    setLoaded(false);
    _vatomMessageHandler.setController = _controller;
    _vatomMessageHandler.handle("vatomwallet:pre-init", initSDK);
    _vatomMessageHandler.handle("vatomwallet:loaded", walletIsLoaded);

    if (onInventoryUpdate != null) {
      _vatomMessageHandler.handle(
          "walletsdk:inventoryWasUpdated", onInventoryUpdate as Function);
    }

    if (onCustomActionReceived != null) {
      _vatomMessageHandler.handle(
          "walletsdk:sendCustomAction", onCustomActionReceived as Function);
    }

    if (onMessageReceived != null) {
      _vatomMessageHandler.handle(
          "walletsdk:sdkMessage", onMessageReceived as Function);
    }

    // String? currentUrl = await getFromLocalStorage(routeKey);

    // if (currentUrl == null || currentUrl == '') {
    String url = createUrl();

    _controller.loadRequest(Uri.parse(url));
    // } else {
    //   _controller.loadRequest(Uri.parse(currentUrl));
    // }
  }

  String createUrl() {
    String src = config?.baseUrl ?? "https://wallet.vatom.com";

    if (businessId != null) {
      print(
          "Business ID was passed trough config, this is deprecated and will be removed in the future. Please pass the path you intend to use in the config to target the expected initial route. i.e. /b/:businessId  /b/:businessId/map");

      if (config?.path == null) {
        src += "/b/$businessId";
      } else {
        print(
            'Both businessId and path were passed, the path will be used instead of the businessId');
      }
    }

    if (config?.path != null) {
      src += config?.path ?? "";
    }

    return src;
  }

  String createUrlWithTab([String? tab]) {
    String src = config?.baseUrl ?? "https://wallet.vatom.com";

    if (businessId != null) {
      src += "/b/$businessId";
    }

    if (tab != null) {
      if (tab.startsWith("/")) {
        tab = tab.substring(1);
      }

      src += "/$tab";
    }

    return src;
  }

  initSDK() {
    try {
      // print("CONSOLE initSDK accessToken: $accessToken");
      // set location handler
      _vatomMessageHandler.handle('vatomwallet:getCurrentPosition',
          VatomLocationHandler().responseMessage);

      // init SDK
      sendMsgWithoutResponse("wallet-sdk-init", {
        "accessToken": accessToken,
        "embeddedType": "flutter-${Platform.operatingSystem}",
        "businessId": businessId,
        "walletConfig": config?.walletConfig?.toJson() ?? AppConfiguration(),
        "config": config?.toJson(),
        "refreshToken": refreshToken
      });
      started = true;
    } catch (error) {
      print("initSDK.error: ${error.toString()}");
    }
  }

  walletIsLoaded() {
    if (!loaded) {
      setLoaded(true);
    }
  }

  setLoaded(bool state) {
    loaded = state;
  }

  // _setCurrentUrl(String url) {
  //   saveToLocalStorage(routeKey, url);
  // }

  // void saveToLocalStorage(String key, String value) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString(key, value);
  // }

  // Future<String?> getFromLocalStorage(String key) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(key);
  // }

  doNothingAction(dynamic x) {
    return;
  }

  sendMsgWithoutResponse(String name, Object? payload) {
    _vatomMessageHandler.sendMsg(name, payload).catchError(doNothingAction);
  }

  // setInitialRoute() {
  //   String url = createUrl();
  //   _controller.loadRequest(Uri.parse(url));
  // }

  // Function to be called by the host to perform an action on a token
  Future performAction(
      String tokenId, String actionName, Object? payload) async {
    return await _vatomMessageHandler.sendMsg('walletsdk:performAction', {
      "tokenId": tokenId,
      "actionName": actionName,
      "actionPayload": payload
    });
  }

  // Function to be called by the host to combine tokens
  Future combineTokens(String thisTokenId, String otherTokenId) async {
    return await _vatomMessageHandler.sendMsg('walletsdk:combineToken',
        {"thisTokenId": thisTokenId, "otherTokenId": otherTokenId});
  }

  // Function to be called by the host to trash a token
  Future trashToken(String tokenId) async {
    return await _vatomMessageHandler
        .sendMsg('walletsdk:trashToken', {"tokenId": tokenId});
  }

  // Function to be called by the host to get a token
  Future getToken(String tokenId) async {
    return await _vatomMessageHandler
        .sendMsg('walletsdk:getToken', {"tokenId": tokenId});
  }

  Future<bool> isNavigationReady() async {
    try {
      // print("CONSOLE on isNavigationReady");
      final res = await _vatomMessageHandler.sendMsg(
          'walletsdk:navigationIsReady', null, 250);
      // print("CONSOLE isNavigationReady res: $res");
      return res;
    } catch (err) {
      // print('CONSOLE.isNavigationReady error $err');
      return false;
    }
  }

  // Function to be called by the host to get a public token
  Future getPublicToken(String tokenId) async {
    return await _vatomMessageHandler
        .sendMsg('walletsdk:getPublicToken', {tokenId: "tokenId"});
  }

  // Function to be called by the host to get the list of tokens the user owns
  Future listTokens() async {
    return await _vatomMessageHandler.sendMsg('walletsdk:listTokens');
  }

  Future isLoggedIn() async {
    return await _vatomMessageHandler.sendMsg('walletsdk:isLoggedIn');
  }

  Future getPublicProfile(String? userId) async {
    return await _vatomMessageHandler
        .sendMsg("walletsdk:getPublicProfile", {"userId": userId});
  }

  Future getCurrentUserPoints(String campaignId) async {
    return await _vatomMessageHandler
        .sendMsg("walletsdk:getCurrentUserPoints", {"campaignId": campaignId});
  }

  Future<UserData?> getCurrentUser() async {
    try {
      dynamic user =
          await _vatomMessageHandler.sendMsg('walletsdk:getCurrentUser');
      return UserData.fromJson(jsonDecode(user));
    } catch (e) {
      print("getCurrentUser error $e");
      return null;
    }
  }

  @Deprecated("Use linkTo instead")
  Future navigateToTab(String tabRoute, [Map<String, dynamic>? params]) async {
    // print("CONSOLE navigateToTab: $tabRoute");

    // print("CONSOLE loaded: $loaded");
    if (!loaded) {
      String url = createUrlWithTab(tabRoute.toLowerCase());
      _controller.loadRequest(Uri.parse(url));

      return;
    }
    var navigationIsReady = await isNavigationReady();
    // print("CONSOLE navigationIsReady: $navigationIsReady  ");
    if (!navigationIsReady) {
      String url = createUrlWithTab(tabRoute.toLowerCase());
      _controller.loadRequest(Uri.parse(url));
      return;
    }
    await Future.delayed(const Duration(microseconds: 100));
    _vatomMessageHandler.sendMsg("walletsdk:navigate", {
      "route": tabRoute,
      "params": {
        "businessId": businessId,
        ...params ?? {},
      },
    });
  }

  Future linkTo(String url) async {
    if (!loaded) {
      String link = createUrlWithTab(url);

      _controller.loadRequest(Uri.parse(link));
    }

    var navigationIsReady = await isNavigationReady();

    if (!navigationIsReady) {
      String link = createUrlWithTab(url);
      _controller.loadRequest(Uri.parse(link));
      return;
    }

    await Future.delayed(const Duration(microseconds: 100));

    if (businessId != null && !url.contains("/b/$businessId")) {
      if (url[0] != "/") {
        url = "/$url";
      }
      url = "/b/$businessId$url";
    }
    dynamic res = await _vatomMessageHandler.sendMsg("walletsdk:linkTo", {
      "url": url,
    });
    return res;
  }

  Future getTabs() async {
    var tabs = await _vatomMessageHandler.sendMsg("walletsdk:getBusinessTabs");
    List<String> myList = jsonDecode(tabs).cast<String>();
    return myList;
  }

  Future navigate(String route, [Map<String, dynamic>? params]) {
    return sendMsgWithoutResponse("walletsdk:navigate", {
      "route": route,
      "params": {
        "businessId": businessId,
        ...params ?? {},
      },
    });
  }

  Future openToken(String tokenId) {
    var route = "NFTDetail";

    if (businessId != null) {
      route = "NFTDetail_Business";
    }
    return sendMsgWithoutResponse("walletsdk:navigate", {
      "route": route,
      "params": {"business": businessId, "tokenId": tokenId},
    });
  }

  Future logOut() async {
    _controller.clearCache();
    _controller.clearLocalStorage();
    accessToken = null;
    refreshToken = null;
    initialRoute = null;

    _controller.reload();

    return await _vatomMessageHandler.sendMsg("walletsdk:logOut");
  }

  Future openCommunity(String communityId, {String? roomId}) async {
    return await _vatomMessageHandler.sendMsg("walletsdk:openCommunity", {
      "bussinesId": businessId,
      "communityId": communityId,
      "roomId": roomId,
    });
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      controller: _controller,
    );
  }
}
