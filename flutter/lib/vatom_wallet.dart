import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'vatom_classes.dart';
import 'vatom_location_handler.dart';
import 'vatom_message_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:permission_handler/permission_handler.dart';

class VatomWallet extends StatefulWidget {
  final Widget? title;
  final String? accessToken;
  final String? businessId;

  final VatomConfigFeatures? config;

  const VatomWallet(
      {super.key, this.title, this.accessToken, this.businessId, this.config});

  @override
  State<StatefulWidget> createState() => VatomWalletState();
}

class VatomWalletState extends State<VatomWallet> {
  late WebViewController _controller;
  final _vatomLocationHandler = VatomLocationHandler();
  final VatomMessageHandler _vatomMessageHandler = VatomMessageHandler();
  final tabsRoutesAllowed = ['Home', 'Wallet', 'Map', 'MapAr', 'Connect'];

  var loaded = false;
  var started = false;

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

  @override
  void initState() {
    super.initState();

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
          onProgress: (int progress) {
            if (progress == 100) {
              initSDK();
            }
          },
          // onPageStarted: (String url) {
          //   // print('Page started loading: $url');
          // },
          // onPageFinished: (String url) {
          //   if (!loaded) {
          //     initSDK();
          //   }
          // },
          onWebResourceError: (WebResourceError error) {
            print(error.description);
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.isMainFrame &&
                !request.url.contains("vatom") &&
                !request.url.contains("ngrok") &&
                !request.url.contains("https://www.google.com/recaptcha")) {
              launchUrl(Uri.parse(request.url));
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel('vatomMessageHandler',
          onMessageReceived: _vatomMessageHandler.onMessage);

    // Debugg ios
    if (_controller.platform is WebKitWebViewController && kDebugMode) {
      (_controller.platform as WebKitWebViewController).setInspectable(true);
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

    _vatomMessageHandler.setController = _controller;
    _vatomMessageHandler.handle("vatomwallet:pre-init", initSDK);
    _controller.loadRequest(Uri.parse(
        "${widget.config?.baseUrl ?? "https://wallet.vatominc.com"}${widget.businessId != null ? "/b/${widget.businessId}" : ""}"));
  }

  initSDK() {
    try {
      // set location handler
      _vatomMessageHandler.handle('vatomwallet:getCurrentPosition',
          VatomLocationHandler().responseMessage);
      // init SDK
      _vatomMessageHandler.sendMsg("wallet-sdk-init", {
        "accessToken": widget.accessToken,
        "embeddedType": "flutter-${Platform.operatingSystem}",
        "businessId": widget.businessId,
        "config": widget.config?.toJson(),
      });
      setState(() {
        loaded = true;
      });
    } catch (error) {
      print("initSDK.error: ${error.toString()}");
    }
  }

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

  Future navigateToTab(String tabRoute, [Map<String, dynamic>? params]) async {
    if (!tabsRoutesAllowed.contains(tabRoute)) {
      throw Exception(
          "Route not allowed $tabRoute, allowed $tabsRoutesAllowed");
    }
    return await _vatomMessageHandler.sendMsg("walletsdk:navigateToTab", {
      "route": tabRoute,
      "params": {
        "businessId": widget.businessId,
        ...params ?? {},
      },
    });
  }

  Future getTabs() async {
    var tabs = await _vatomMessageHandler.sendMsg("walletsdk:getBusinessTabs");
    List<String> myList = jsonDecode(tabs).cast<String>();
    return myList;
  }

  Future navigate(String route, [Map<String, dynamic>? params]) async {
    return await _vatomMessageHandler.sendMsg("walletsdk:navigate", {
      "route": route,
      "params": {
        "businessId": widget.businessId,
        ...params ?? {},
      },
    });
  }

  Future openNFTDetail(String tokenId) async {
    var route = "NFTDetail";

    if (widget.businessId != null) {
      route = "NFTDetail_Business";
    }
    return await _vatomMessageHandler.sendMsg("walletsdk:navigate", {
      "route": route,
      "params": {"business": widget.businessId, "tokenId": tokenId},
    });
  }

  Future logOut() async {
    return await _vatomMessageHandler.sendMsg("walletsdk:logOut");
  }

  Future openCommunity(String communityId, {String? roomId}) async {
    return await _vatomMessageHandler.sendMsg("walletsdk:openCommunity", {
      "bussinesId": widget.businessId,
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
