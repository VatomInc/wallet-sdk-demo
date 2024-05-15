import 'package:flutter/material.dart';
import 'package:vatom_wallet_sdk/vatom_wallet_sdk.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();

  final VatomWallet wallet = VatomWallet(
    accessToken: "...accessToken",
    refreshToken: "...refreshToken",
    initialRoute: "map",
    config: VatomConfigFeatures(
      hideTokenActions: true,
      disableArPickup: true,
      disableNewTokenToast: true,
      hideDrawer: false,
      hideNavigation: false,
      language: "en",
      scanner: ScannerFeatures(enabled: false),
      pageConfig: PageConfig(
        features: PageFeatures(
          icon: PageFeaturesIcon(badges: false, editions: false, titles: false),
          footer: PageFeaturesFooter(enabled: true, icons: [
            PageFeaturesFooterIcon(id: "map", src: "", title: "Map"),
          ]),
        ),
      ),
    ),
  );

  void linkTo(String path) async {
    wallet.linkTo(path).catchError(
          (error) => print('Error: $error'),
        );
  }

  runApp(
    MaterialApp(
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
                      onPressed: () {
                        linkTo("/");
                      },
                      child: Text('home'),
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(3),
                    child: ElevatedButton(
                      onPressed: () {
                        linkTo("/ar");
                      },
                      child: Text('ar'),
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
    ),
  );
}
