import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:vatom_flutter/vatom_classes.dart';
import 'package:vatom_flutter/vatom_wallet.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late VatomWallet wallet;

  @override
  void initState() {
    super.initState();
    wallet = initializeWallet();

    wallet.on('closeVatom', (data) {
      final token = data["token"];

      final private = token["private"];

      final quiz = private["quiz-v2"];
      print("walletsdk:analytics quiz: $quiz");
      final poll = private["poll-v1"];
      print("walletsdk:analytics poll: $poll");

//       lutter: walletsdk:analytics: openVatom
// flutter: walletsdk:analytics: performAction
// flutter: walletsdk:analytics: closeVatom
// flutter: walletsdk:analytics quiz: null
// flutter: walletsdk:analytics poll: {lastReplied: , question:  , response: , responseOptions: [Pizza, Chocolate, Pasta, Cake]}
// flutter: walletsdk:analytics: openVatom
// flutter: walletsdk:analytics: closeVatom
// flutter: walletsdk:analytics quiz: {answerOptions: [up to Zero Feel, up to Zero Leaks, up to Zero Bulk, All of the above!], clue: , lastPlayed: , question: , status: }
// flutter: walletsdk:analytics poll: null

// contestadas

// flutter: walletsdk:analytics: closeVatom
// flutter: walletsdk:analytics quiz: null
// flutter: walletsdk:analytics poll: {lastReplied: 2024-08-07T22:26:15.637Z, question:  , response: Pizza, responseOptions: [Pizza, Chocolate, Pasta, Cake], results: {Chocolate: 2, Pizza: 2}}

// flutter: walletsdk:analytics quiz: {answerOptions: [up to Zero Feel, up to Zero Leaks, up to Zero Bulk, All of the above!], clue: , lastPlayed: , question: , status: solved}

// flutter: walletsdk:analytics: viewer.view.close
// flutter: walletsdk:analytics: webBridgeEvent
// flutter: walletsdk:analytics: closeVatom
// flutter: walletsdk:analytics quiz: {answerOptions: [up to Zero Feel, up to Zero Leaks, up to Zero Bulk, All of the above!], clue: , lastPlayed: , question: , status: unsolved}
// flutter: walletsdk:analytics poll: null

// PERFORM ACTION
// flutter: walletsdk:analytics: performAction
// flutter: walletsdk:analytics:  payload[payload] {event: performAction, eventValue: 1, actionUri: varius.action:varius.io:submit-poll-v1, campaignUri: lDAKDnxh1j, businessId: jwUipscNvd, objectDefinitionUri: D4l9pLrXJr, templateVariationName: com.vatominc::d8e811f7-38a9-42e2-82ca-d535a5c86211::v1::Variation::v1, digitalObjectId: 1265a152-6783-403a-8886-4b2b6674fe02, userId: dft7pbc, provider: vatominc, networkUserId: 7d665219-2e79-4366-8265-d383a0631479, network: vatominc, viewerId: 94JHkdj8jF83jfFF2LI8Q4, viewerUri: varius.viewer:varius.io:94JHkdj8jF83jfFF2LI8Q4, vatomId: 1265a152-6783-403a-8886-4b2b6674fe02, blueprintId: FFoRFnEVnh15vrRKTxlOa, campaignId: lDAKDnxh1j, distributionId: , objectDefinitionId: D4l9pLrXJr}
    });
  }

  VatomWallet initializeWallet() {
    return VatomWallet(
      accessToken:
          "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Imw0Mjd4WnJxNjJlR0xhS0hhc0d0bkkyZ1JZVjF3c0VUUm0weDlDcEZiOWsifQ.eyJ1cm46dmF0b21pbmM6Z3Vlc3QiOmZhbHNlLCJ1cm46dmF0b21pbmM6cmVnaW9uIjoidXMtZWFzdDQuZ2NwIiwianRpIjoiaFItbGNsU2pCNVRTblF2QjQ2czkzIiwic3ViIjoiMGUzN3Y5bCIsImlhdCI6MTcyMzE1MDY3MiwiZXhwIjoxNzIzMTU0MjcyLCJzY29wZSI6Im9wZW5pZCBwcm9maWxlIGVtYWlsIG9mZmxpbmVfYWNjZXNzIiwiaXNzIjoiaHR0cHM6Ly9pZC52YXRvbS5jb20iLCJhdWQiOiI5NEpIa2RqOGpGODNqZkZGMkxJOFE0In0.IvRu4LhuTGmRxXv0kLvs2rIIG7LybU4AYuDUnLZQVh9OyGLiR9_Ou4MUJ0SrexHgKVwvOLOIBn8qaK_WrqtLgbk0AX4AXQz0-Zg9SqQQP8165XpyakFI1uyTs4SA18-KuLlhBZKHvyB-2mExoBqITGD9FLfs7suw7xgBtegRqNUDYmCUZvJFzzbH0rGbjYZn0gFnug-VmVqDmgwGv1XaZ07UnHZ8g0LGtc0vsTuaN8mLi9KE6zSSDDL6fYg1lVH051orxrR8rbgh69vFMOpK-ymG1Q7ajY00mMLrBKPDwvOzmSSpmBHPRl09lUICrhVhbEOF4EPqUGqNBXWtixc2MA",
      initialRoute: "map",
      onCustomActionReceived: customActionReceived,
      onMessageReceived: onMessageReceived,
      config: VatomConfigFeatures(
        hideTokenActions: false,
        baseUrl: "http://wallet.localhost:3000",
        // baseUrl: "https://wallet.vatom.com",
        disableArPickup: true,
        disableNewTokenToast: true,
        hideDrawer: false,
        hideNavigation: false,
        language: "en",
        scanner: ScannerFeatures(enabled: false),
        pageConfig: PageConfig(
          features: PageFeatures(
            icon:
                PageFeaturesIcon(badges: false, editions: false, titles: false),
            footer: PageFeaturesFooter(enabled: true, icons: [
              PageFeaturesFooterIcon(id: "map", src: "", title: "Map"),
            ]),
          ),
        ),
        path:
            "/b/jwUipscNvd/find-token?campaignId=lDAKDnxh1j&objectDefinitionId=D4l9pLrXJr&autoClaim=true&sync=true",
        walletConfig: AppConfiguration(
          features: FeaturesConfig(
            filtersUserInventory: "Coupons",
            hideCloseButtonOnNft: false,
            customActionBtn: IconConfig(
              icon:
                  "https://resources.vatom.com/Cox1qh6ggb/joy_action_button.png",
              style: {
                "height": "40px",
                "width": "120px",
                "objectFit": 'contain'
              },
            ),
            customActions: List<ActionConfig>.from(
              [
                ActionConfig(
                  action: "goamaGame:getVatom",
                  text: "Hola",
                  style: {
                    "color": '#1443FF',
                    "fontSize": "16px",
                    "fontWeight": "100"
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onMessageReceived(data) {
    print("onMessageReceived token: ${data["token"]}");
    print("onMessageReceived data: ${data["data"]}");
    print("onMessageReceived name: ${data["name"]}");
    // dynamic json = jsonDecode(data);
    // print("onMessageReceived token: ${json["token"]}");
    // print("onMessageReceived data: ${json["data"]}");
  }

  void customActionReceived(data) {
    String token = data["token"];
    String metadata = data["metadata"];

    Map<String, dynamic> tokenJson = json.decode(token);
    print("metadata ${metadata}");
    // try {
    //   transferTokenToGoama(tokenJson["id"], tokenJson["type"]);
    // } catch (e) {
    //   print("Error: $e");
    // }
  }

  void transferTokenToGoama(String tokenid, String tokenType) async {
    try {
      String vatomId = "1lnyl8e";
      String blockvId = "fd42ea68-12e0-463b-9a7f-f067369e4d12";

      String destination = tokenType == "vatom-new" ? vatomId : blockvId;

      dynamic json = {"userID": destination};

      wallet.performAction(tokenid, "Transfer", json);
      wallet.linkTo("/");
    } catch (e) {
      print("Error: $e");
    }
  }

  void linkTo(String path) async {
    wallet.linkTo(path).catchError(
          (error) => print('Error: $error'),
        );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: wallet,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(3),
                    child: ElevatedButton(
                      onPressed: () async {
                        var tabs = await wallet.getCurrentUser();
                        print(tabs?.toJson());
                      },
                      child: Text('getCurrentUser'),
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.all(3),
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       linkTo("/token/5050f3cd-ed2e-4412-87e3-4fa5fec2b7b5");
                  //     },
                  //     child: Text('token'),
                  //     style: ElevatedButton.styleFrom(
                  //       textStyle: const TextStyle(fontSize: 12),
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.all(3),
                  //   child: ElevatedButton(
                  //     onPressed: () async {
                  //       String points =
                  //           await wallet.getCurrentUserPoints("QkxH4IbOIl");

                  //       print("points: $points");
                  //     },
                  //     child: const Text('get points'),
                  //     style: ElevatedButton.styleFrom(
                  //       textStyle: const TextStyle(fontSize: 12),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.all(3),
                    child: ElevatedButton(
                      onPressed: () async {
                        String points = await wallet.linkTo(
                            "/b/jwUipscNvd/find-token?campaignId=lDAKDnxh1j&objectDefinitionId=D4l9pLrXJr&autoClaim=true&sync=true");

                        print("points: $points");
                      },
                      child: const Text('find poll'),
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(3),
                    child: ElevatedButton(
                      onPressed: () async {
                        String points = await wallet.linkTo(
                            "/b/jwUipscNvd/find-token?campaignId=lDAKDnxh1j&objectDefinitionId=Bl50jKxgg0&autoClaim=true&sync=true");

                        print("points: $points");
                      },
                      child: const Text('find quiz'),
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
