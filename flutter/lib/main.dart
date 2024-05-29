import 'package:flutter/material.dart';
import 'package:vatom_flutter/vatom_classes.dart';
import 'package:vatom_flutter/vatom_wallet.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();

  String route = "map";

  final VatomWallet wallet = VatomWallet(
    accessToken:
        "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Imw0Mjd4WnJxNjJlR0xhS0hhc0d0bkkyZ1JZVjF3c0VUUm0weDlDcEZiOWsifQ.eyJ1cm46dmF0b21pbmM6bG9nZ2VkLWluLXZpYSI6Im1hZ2ljLWNvZGUiLCJ1cm46dmF0b21pbmM6Z3Vlc3QiOmZhbHNlLCJ1cm46dmF0b21pbmM6cmVnaW9uIjoidXMtZWFzdDQuZ2NwIiwianRpIjoia2dtUGloV3J1bU9xNDJXOVVfVE9XIiwic3ViIjoiMGUzN3Y5bCIsImlhdCI6MTcxNzAxMjgzNywiZXhwIjoxNzE3MDE2NDM3LCJzY29wZSI6Im9wZW5pZCBwcm9maWxlIGVtYWlsIG9mZmxpbmVfYWNjZXNzIiwiaXNzIjoiaHR0cHM6Ly9pZC52YXRvbS5jb20iLCJhdWQiOiI5NEpIa2RqOGpGODNqZkZGMkxJOFE0In0.eZMzWFsGDrpaPYcqb9hwp-BC-bxJAj3Yeh9HwujFprl8e6b9G7C6UwEP9sQ1UnLzzO3EgMNlwsX4-ZQ1DqLQPL20Nfmt9uHLOW5drYf_wF4ltbQPfQJItU76RDyELHI-zlqRhoH6dx7xqZIppJ1MOLNu6A_IwpHUTGssHhB3VEe8GKtZuyyyB9VnqdK9uQURfI_xrhcosXmwPNae8_THur1cPmCgSWVJ6UR34uW7a_gAUw68r2XTbwRkYI1EZaFZOG9Hikfkg6BOlXCBseiYxd2RJhajwcGPSFd49Af8LXbtL1gEzdh0lcXr2w1g_dONl3bJ4mkp_DvDeKHoQezAyA",
    config: VatomConfigFeatures(
      systemThemeOverride: "dark",
      path: "/b/QkxH4IbOIl/$route",
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
                        onPressed: () async {
                          var tabs = await wallet.getCurrentUser();
                          print(tabs?.toJson());
                        },
                        child: Text('getCurrentUser'),
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 12),
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.all(3),
                    child: ElevatedButton(
                      onPressed: () {
                        linkTo("/b/QkxH4IbOIl/map");
                      },
                      child: Text('map'),
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(3),
                      child: ElevatedButton(
                        onPressed: () async {
                          linkTo("/b/QkxH4IbOIl/wallet");
                        },
                        child: const Text('wallet'),
                        //break text to avoid overflow
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 12),
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
