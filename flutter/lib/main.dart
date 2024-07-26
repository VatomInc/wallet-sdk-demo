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
  }

  VatomWallet initializeWallet() {
    return VatomWallet(
      accessToken:
          "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Imw0Mjd4WnJxNjJlR0xhS0hhc0d0bkkyZ1JZVjF3c0VUUm0weDlDcEZiOWsifQ.eyJ1cm46dmF0b21pbmM6Z3Vlc3QiOmZhbHNlLCJ1cm46dmF0b21pbmM6cmVnaW9uIjoidXMtZWFzdDQuZ2NwIiwianRpIjoiZXRkbDdVOERMRTZOSlFUVUtxZXpOIiwic3ViIjoiMGUzN3Y5bCIsImlhdCI6MTcyMTI1OTA0NiwiZXhwIjoxNzIxMjYyNjQ2LCJzY29wZSI6Im9wZW5pZCBwcm9maWxlIGVtYWlsIG9mZmxpbmVfYWNjZXNzIiwiaXNzIjoiaHR0cHM6Ly9pZC52YXRvbS5jb20iLCJhdWQiOiI5NEpIa2RqOGpGODNqZkZGMkxJOFE0In0.k45kI8unleV8PAlRX4V58EMU4CLxPkmmEyiw4dSpcMSvQQLpvgXicTsxpwNrg2i10vULtBRecimWlHqtK-XtyPJZh60xprvUInkPgRG-RNNofwGQnmgfQX4AmOKvcWF3GdGY8kDarGzKSGaKzPJp0wEoewRHDrzk2rIDmwtwN_Jdo1TNA1kdJMwisbkddRtOeL9q97efwhmReFkhCBK-Kwq2l-391cKenWJQgxFs0PyYy2MGM9ujt9N0FgQNsULEH38aNhIJGr05I2LybHG2l4tMIk6lT1TklWenBDA8itwKZH4pZcZ055PfaNmGlVal7xLxewutvMiSjrBd6hRE0w",
      initialRoute: "map",
      onCustomActionReceived: customActionReceived,
      businessId: "nCHNthBpv7",
      config: VatomConfigFeatures(
        // path: "/token/h1cslfJGN9",
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
                  Padding(
                    padding: EdgeInsets.all(3),
                    child: ElevatedButton(
                      onPressed: () {
                        linkTo("/token/5050f3cd-ed2e-4412-87e3-4fa5fec2b7b5");
                      },
                      child: Text('token'),
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(3),
                    child: ElevatedButton(
                      onPressed: () async {
                        String points =
                            await wallet.getCurrentUserPoints("QkxH4IbOIl");

                        print("points: $points");
                      },
                      child: const Text('get points'),
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
