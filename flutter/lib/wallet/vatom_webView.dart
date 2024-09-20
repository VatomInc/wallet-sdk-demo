// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vatom_wallet_sdk/wallet/vatom_classes.dart';
import 'package:vatom_wallet_sdk/wallet/vatom_location_handler.dart';
import 'package:vatom_wallet_sdk/wallet/vatom_message_handler.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'dart:async';

class VatomWalletWeb extends StatelessWidget with WidgetsBindingObserver {
  final String vatomUrlProd = "https://wallet.vatom.com";
  late WebViewController _controller;
  final _vatomLocationHandler = VatomLocationHandler();
  final VatomMessageHandler _vatomMessageHandler = VatomMessageHandler();
  final Map<String, Function> _messageHandlersWebView = {};
  late Map<String, Function> _handlers = {};

  late String? accessToken;
  late String? refreshToken;
  late String? businessId;
  final VatomConfigFeatures? config;
  final Function? onInventoryUpdate;
  final Function? onCustomActionReceived;

  VatomWalletWeb({
    super.key,
    this.accessToken,
    this.refreshToken,
    this.businessId,
    this.config,
    this.onInventoryUpdate,
    this.onCustomActionReceived,
  }) {
    _handlers = {
      "vatomwallet:pre-init": _initSDK,
      "vatomwallet:getCurrentPosition": VatomLocationHandler().responseMessage,
      "walletsdk:inventoryWasUpdated": onInventoryUpdate ?? () => {},
      "walletsdk:sendCustomAction": onCustomActionReceived ?? () => {},
      "vatomwallet:loaded": () => {},
    };

    initState();
    WidgetsBinding.instance.addObserver(this);
  }

  void initState() async {
    late PlatformWebViewControllerCreationParams params;

    // Set platform-specific WebViewController parameters: custom for iOS, default for others.
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    _controller = WebViewController.fromPlatformCreationParams(params,
        onPermissionRequest: _onPermissionRequest)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(NavigationDelegate(
        onWebResourceError: _onWebResourceError,
        onNavigationRequest: _onNavigationRequest,
        onHttpError: _onHtppError,
      ))
      ..addJavaScriptChannel("vatomMessageHandler",
          onMessageReceived: _addJavaScriptChannel);

    _enableWebViewInspection();
    _configureAndroidWebView();
    _vatomMessageHandler.setController = _controller;
    _registerHandlers();
    _loadRequest();
  }

  _loadRequest() {
    try {
      String url = createUrl();
      print("VATOM.LOG: Loading URL: $url");
      _controller.loadRequest(Uri.parse(url));
    } catch (error) {
      print("VATOM.LOG: Error in _loadRequest:${error.toString()}");
    }
  }

  createUrl() {
    try {
      String src = config?.baseUrl ?? urlProd;

      if (businessId != null) {
        print(
            "VATOM.LOG: Business ID was passed trough config, this is deprecated and will be removed in the future. Please pass the path you intend to use in the config to target the expected initial route. i.e. /b/:businessId  /b/:businessId/map");

        if (config?.path == null) {
          src += "/b/$businessId";
        } else {
          print(
              'VATOM.LOG: Both businessId and path were passed, the path will be used instead of the businessId');
        }
      }

      if (config?.path != null) {
        src += config?.path ?? "";
      }

      return src;
    } catch (error) {
      print("VATOM.LOG: Error in _createUrl:${error.toString()}");
    }
  }

  _onPermissionRequest(WebViewPermissionRequest request) async {
    try {
      // Check if the permission request is for camera access
      if (request.types.contains(WebViewPermissionResourceType.camera)) {
        // Determine if the camera permission has already been granted
        bool isCameraGranted = await Permission.camera.isGranted;

        if (!isCameraGranted) {
          // Request camera permission from the user
          if (await Permission.camera.request().isGranted == false) {
            // If the user denies the permission, deny the WebView permission request
            request.deny();
          } else {
            // If the user grants the permission, grant the WebView permission request
            request.grant();
          }
        } else {
          // If the camera permission is already granted, grant the WebView permission request
          request.grant();
        }
      }
    } catch (error) {
      print("VATOM.LOG: Error in _onPermissionRequest: ${error.toString()}");
    }
  }

  _onHtppError(HttpResponseError error) {
    print(
        "VATOM.LOG: Warning in _onHtppError: ${error.toString()}, { statusCode: ${error.response?.statusCode}, uri: ${error.response?.uri} }");
  }

  _onWebResourceError(WebResourceError error) {
    print(
        "VATOM.LOG: Error in _onWebResourceError: { errorCode: ${error.errorCode}, description: ${error.description}, errorType: ${error.errorType} }");
  }

  FutureOr<NavigationDecision> _onNavigationRequest(NavigationRequest request) {
    try {
      final url = request.url;

      // Open external URLs if they are not from allowed domains
      if (request.isMainFrame && !_isAllowedDomain(url)) {
        launchUrl(Uri.parse(url));
        return NavigationDecision
            .prevent; // Prevent WebView from handling the URL
      }

      // Prevent navigation for geo URIs
      if (url.startsWith("geo:")) {
        return NavigationDecision.prevent;
      }

      // Allow navigation for all other requests
      return NavigationDecision.navigate;
    } catch (error) {
      print("VATOM.LOG: Error in _onNavigationRequest: ${error.toString()}");
      return NavigationDecision.navigate;
    }
  }

  bool _isAllowedDomain(String url) {
    return url.contains("vatom") ||
        url.contains("localhost") ||
        url.contains("ngrok") ||
        url.contains("https://www.google.com/recaptcha");
  }

  void _addJavaScriptChannel(JavaScriptMessage message) {
    try {
      // Decode the incoming JavaScript message
      final data = _vatomMessageHandler.decodeMessage(message);

      // Extract the name and payload from the decoded data
      final name = data?.name;
      final payload = data?.payload;

      // Check if the message is related to analytics
      if (name == "walletsdk:analytics" && payload is Map) {
        // Extract the event name from the payload
        final eventName = payload["name"];

        // If a handler exists for the event, invoke it with the payload
        if (_messageHandlersWebView.containsKey(eventName)) {
          _messageHandlersWebView[eventName]!({
            "token": payload["token"] ?? {},
            "payload": payload["payload"] ?? {},
          });
        }
      } else {
        // Handle other messages through the vatomMessageHandler
        _vatomMessageHandler.onMessage(message);
      }
    } catch (error) {
      print("VATOM.LOG: Error in _addJavaScriptChannel:${error.toString()}");
    }
  }

  void _enableWebViewInspection() {
    try {
      // Enable WebView inspection for iOS devices running iOS version greater than 16.4 in debug mode
      if (_controller.platform is WebKitWebViewController && kDebugMode) {
        // Obtain device information using the DeviceInfoPlugin
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

        // Fetch iOS device information asynchronously
        deviceInfo.iosInfo.then((iosInfo) {
          try {
            // Split the system version into parts (e.g., "16.4.1" -> ["16", "4", "1"])
            var version = iosInfo.systemVersion.split(".");

            // Convert the major and minor version (e.g., "16.4") to a double for comparison
            var versionNumber = double.parse("${version[0]}.${version[1]}");

            // If the iOS version is greater than 16.4, enable WebView inspection
            if (versionNumber > 16.4) {
              (_controller.platform as WebKitWebViewController)
                  .setInspectable(true);
            }
          } catch (e) {
            // Log any errors that occur during the version parsing or inspection enabling
            print("VATOM.LOG: Error during WebView inspection setup: $e");
          }
        }).catchError((e) {
          // Log any errors that occur while fetching device information
          print("VATOM.LOG: Error fetching iOS device info: $e");
        });
      }
    } catch (e) {
      // Log any errors that occur outside of the asynchronous calls
      print("VATOM.LOG: Error in enableWebViewInspection: $e");
    }
  }

  void _configureAndroidWebView() {
    try {
      // Configure debugging and permissions specifically for Android WebView
      if (_controller.platform is AndroidWebViewController) {
        // Enable WebView debugging in debug mode
        if (kDebugMode) {
          AndroidWebViewController.enableDebugging(true);
        }

        // Set media playback to not require user gesture
        (_controller.platform as AndroidWebViewController)
            .setMediaPlaybackRequiresUserGesture(false);

        // Set geolocation permission prompt callbacks
        (_controller.platform as AndroidWebViewController)
            .setGeolocationPermissionsPromptCallbacks(
                onShowPrompt: (_vatomLocationHandler.handleAndroidPermission));
      }
    } catch (e) {
      // Log any errors that occur during the configuration
      print("VATOM.LOG: Error in configureAndroidWebView: $e");
    }
  }

  _initSDK() {
    try {
      // init SDK
      sendMsgWithoutResponse("wallet-sdk-init", {
        "accessToken": _getAccessToken(),
        "embeddedType": "flutter-${Platform.operatingSystem}",
        "businessId": _getBusinessId(),
        "refreshToken": _getRefreshToken(),
        "config": _getConfig().toJson(),
        "walletConfig": _getWalletConfig().toJson(),
      });
    } catch (error) {
      print("initSDK.error: ${error.toString()}");
    }
  }

  _doNothingAction(dynamic x) {
    return;
  }

  sendMsgWithoutResponse(String name, Object? payload) {
    _vatomMessageHandler.sendMsg(name, payload).catchError(_doNothingAction);
  }

  Future sendMsg(String name, [Object? payload, int? time]) {
    return _vatomMessageHandler.sendMsg(name, payload);
  }

  _registerHandlers() {
    _handlers.forEach((name, handler) {
      try {
        _vatomMessageHandler.handle(name, handler);
      } catch (error) {
        print(
            "VATOM.LOG: Error in _registerHandlers on $name: ${error.toString()}");
      }
    });
  }

  String _getAccessToken() {
    try {
      return accessToken ?? "";
    } catch (error) {
      print("VATOM.LOG: Error in _getAccessToken: ${error.toString()}");
      return "";
    }
  }

  String _getBusinessId() {
    try {
      return businessId ?? "";
    } catch (error) {
      print("VATOM.LOG: Error in _getBusinessId: ${error.toString()}");
      return "";
    }
  }

  String _getRefreshToken() {
    try {
      return refreshToken ?? "";
    } catch (error) {
      print("VATOM.LOG: Error in _getRefreshToken: ${error.toString()}");
      return "";
    }
  }

  VatomConfigFeatures _getConfig() {
    try {
      return config ?? VatomConfigFeatures();
    } catch (error) {
      print("VATOM.LOG: Error in _getConfig:${error.toString()}");
      return VatomConfigFeatures();
    }
  }

  AppConfiguration _getWalletConfig() {
    try {
      return config?.walletConfig ?? AppConfiguration();
    } catch (error) {
      print("VATOM.LOG: Error in _getWalletConfig:${error.toString()}");
      return AppConfiguration();
    }
  }

  get controller {
    return _controller;
  }

  get urlProd {
    return vatomUrlProd;
  }

  registerListener(
    String name,
    Function handler,
  ) {
    try {
      _messageHandlersWebView[name] = handler;
    } catch (error) {
      print("VATOM.LOG: Error in registerHandler:${error.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      controller: _controller,
    );
  }
}
