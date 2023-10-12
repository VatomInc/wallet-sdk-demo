import 'package:flutter/material.dart';
import 'package:vatom_wallet_sdk/vatom_wallet_sdk.dart';

// import 'package:my_app/gradient_color.dart';

main() {
  final vatomKey = GlobalKey<VatomWalletState>();
  final VatomConfig vatomConfig = VatomConfig(
    baseUrl: "https://wallet.vatominc.com",
    features: VatomConfigFeatures(
      hideNavigation: false,
      scanner: ScannerFeatures(enabled: false),
      vatom: VatomFeatures(
        hideTokenActions: true,
        disableNewTokenToast: true,
      ),
    ),
  );

  final VatomWallet wallet = VatomWallet(
    key: vatomKey,
    accessToken: "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Imw0Mjd4WnJxNjJlR0xhS0hhc0d0bkkyZ1JZVjF3c0VUUm0weDlDcEZiOWsifQ.eyJ1cm46dmF0b21pbmM6Z3Vlc3QiOmZhbHNlLCJ1cm46dmF0b21pbmM6cmVnaW9uIjoidXMtZWFzdDQuZ2NwIiwianRpIjoiaW9Ka2dtQUVzM0x1M2hMYTl2MGFXIiwic3ViIjoiMWxueWw4ZSIsImlhdCI6MTY5NzE0OTMwNSwiZXhwIjoxNjk3MTUyOTA1LCJzY29wZSI6Im9wZW5pZCBwcm9maWxlIGVtYWlsIG9mZmxpbmVfYWNjZXNzIiwiaXNzIjoiaHR0cHM6Ly9pZC52YXRvbS5jb20iLCJhdWQiOiI5NEpIa2RqOGpGODNqZkZGMkxJOFE0In0.M7Olf--Sz5g75SO8idcMaMmZATKlAL1kQzpSVsR3SmuWRH51PloRSplXP8aT8g5RZBZb16HHJGJSHTaZe7w4Jl-C99t8p24BUUJ6JKvCRzqSeGBxOg-FoZ5vVAUvq-elvLmRyiTl36-Y2L8zf0ql314clPtG7ZuhXrXOd1iYB_wu4JfWg9W5Z0C7jtDyuphq3vDJxDfh-tgIFJFNyrbDHdfnS-2Ogrsu1sTZh2lQI7HqIoJ8QNDw6cWwlg_zkAoxfuADe0VRe4gAvpjBudOXkyFuNI8vB29AaacCRMRgCE2zHqj9Cd8tDFY0A93VyVVc9TEdPEggzq44iLc4sI90Ug",
    config: vatomConfig,
  );

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
                  ElevatedButton(
                    onPressed: () async {
                      // await vatomKey.currentState?.openCommunity('sahMOa1qQR',
                      //     roomId: '!EcINyJyITqdmqVEAVe%3Avatom.com');
                      var tabs = await vatomKey.currentState?.getCurrentUser();
                      print(tabs?.toJson());
                    },
                    child: Text('getCurrentUser'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await vatomKey.currentState?.navigateToTab("Connect");
                    },
                    child: Text('Connect'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await vatomKey.currentState?.navigateToTab("Home");
                    },
                    child: Text('Home'),
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
// export 'package:vatom_wallet_sdk/VatomClasses.dart';
// export 'package:vatom_wallet_sdk/VatomWallet.dart' show VatomWallet;
