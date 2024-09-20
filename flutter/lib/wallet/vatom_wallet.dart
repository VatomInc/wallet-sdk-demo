// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vatom_wallet_sdk/wallet/vatom_classes.dart';

import 'package:vatom_wallet_sdk/wallet/vatom_webView.dart';

class VatomWallet extends VatomWalletWeb {
  VatomWallet({
    Key? key,
    String? accessToken,
    String? refreshToken,
    String? businessId,
    VatomConfigFeatures? config,
    Function? onInventoryUpdate,
    Function? onCustomActionReceived,
  }) : super(
          key: key,
          accessToken: accessToken,
          refreshToken: refreshToken,
          businessId: businessId,
          config: config,
          onInventoryUpdate: onInventoryUpdate,
          onCustomActionReceived: onCustomActionReceived,
        );

  // @override
  // void initState() {
  //   super.initState();
  // }

  Future linkTo(String url) async {
    await Future.delayed(const Duration(microseconds: 300));

    var navigationIsReady = await isNavigationReady();

    if (navigationIsReady) {
      if (businessId != null && !url.contains("/b/$businessId")) {
        if (url[0] != "/") {
          url = "/$url";
        }
        url = "/b/$businessId$url";
      }

      print("VATOM.LOG: linkTo $url");
      sendMsg("walletsdk:linkTo", {
        "url": url,
      });

      return;
    }

    String link = createUrlWithTab(url);
    print("VATOM.LOG: loadRequest $url");
    controller.loadRequest(Uri.parse(link));

    return;
  }

  Future openCommunity(String communityId, {String? roomId}) async {
    return await sendMsg("walletsdk:openCommunity", {
      "bussinesId": businessId,
      "communityId": communityId,
      "roomId": roomId,
    });
  }

  Future logOut() async {
    controller.clearCache();
    controller.clearLocalStorage();
    accessToken = null;
    refreshToken = null;

    controller.reload();

    return await sendMsg("walletsdk:logOut", null);
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

  Future navigate(String route, [Map<String, dynamic>? params]) {
    return sendMsgWithoutResponse("walletsdk:navigate", {
      "route": route,
      "params": {
        "businessId": businessId,
        ...params ?? {},
      },
    });
  }

  @Deprecated("Use linkTo instead")
  Future navigateToTab(String tabRoute, [Map<String, dynamic>? params]) async {
    await Future.delayed(const Duration(microseconds: 200));

    var navigationIsReady = await isNavigationReady();

    if (!navigationIsReady) {
      String url = createUrlWithTab(tabRoute.toLowerCase());
      controller.loadRequest(Uri.parse(url));
      return;
    }

    sendMsg("walletsdk:navigate", {
      "route": tabRoute,
      "params": {
        "businessId": businessId,
        ...params ?? {},
      },
    });
  }

  Future listTokens() async {
    return await sendMsg('walletsdk:listTokens', null);
  }

  Future isLoggedIn() async {
    return await sendMsg('walletsdk:isLoggedIn', null);
  }

  Future getPublicProfile(String? userId) async {
    return await sendMsg("walletsdk:getPublicProfile", {"userId": userId});
  }

  Future getCurrentUserPoints(String campaignId) async {
    return await sendMsg(
        "walletsdk:getCurrentUserPoints", {"campaignId": campaignId});
  }

  Future<UserData?> getCurrentUser() async {
    try {
      dynamic user = await sendMsg('walletsdk:getCurrentUser', null);
      return UserData.fromJson(jsonDecode(user));
    } catch (e) {
      print("getCurrentUser error $e");
      return null;
    }
  }

  Future getPublicToken(String tokenId) async {
    return await sendMsg('walletsdk:getPublicToken', {tokenId: "tokenId"});
  }

  Future<bool> isNavigationReady() async {
    try {
      final res = await sendMsg('walletsdk:navigationIsReady', null, 250);
      return res;
    } catch (err) {
      return false;
    }
  }

  Future performAction(
      String tokenId, String actionName, Object? payload) async {
    return await sendMsg('walletsdk:performAction', {
      "tokenId": tokenId,
      "actionName": actionName,
      "actionPayload": payload
    });
  }

  Future combineTokens(String thisTokenId, String otherTokenId) async {
    return await sendMsg('walletsdk:combineToken',
        {"thisTokenId": thisTokenId, "otherTokenId": otherTokenId});
  }

  Future trashToken(String tokenId) async {
    return await sendMsg('walletsdk:trashToken', {"tokenId": tokenId});
  }

  Future getToken(String tokenId) async {
    return await sendMsg('walletsdk:getToken', {"tokenId": tokenId});
  }

  String createUrlWithTab([String? tab]) {
    String src = config?.baseUrl ?? urlProd;

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

  on(String name, Function handler) {
    registerListener(name, handler);
  }
}
