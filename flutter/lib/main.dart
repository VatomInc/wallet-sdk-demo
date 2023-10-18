import 'package:flutter/material.dart';
import 'package:vatom_wallet_sdk/vatom_wallet_sdk.dart';

// import 'package:my_app/gradient_color.dart';

main() {
  final vatomKey = GlobalKey<VatomWalletState>();
  final VatomConfig vatomConfig = VatomConfig(
    baseUrl: "https://23e9-201-141-16-18.ngrok-free.app",
    features: VatomConfigFeatures(
      hideNavigation: false,
      scanner: ScannerFeatures(enabled: null),
      vatom: VatomFeatures(
        hideTokenActions: true,
      ),
    ),
  );

  final VatomWallet wallet = VatomWallet(
    key: vatomKey,
    accessToken:
        "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Imw0Mjd4WnJxNjJlR0xhS0hhc0d0bkkyZ1JZVjF3c0VUUm0weDlDcEZiOWsifQ.eyJ1cm46dmF0b21pbmM6Z3Vlc3QiOmZhbHNlLCJ1cm46dmF0b21pbmM6cmVnaW9uIjoidXMtZWFzdDQuZ2NwIiwianRpIjoiRHoxRmhpdERBU2g4WG8zaEFmX1pBIiwic3ViIjoiY3hwNGs5cCIsImlhdCI6MTY5NzQ5Mjg2NywiZXhwIjoxNzAwMDg0ODY3LCJzY29wZSI6Im9wZW5pZCBlbWFpbCBwcm9maWxlIG9mZmxpbmVfYWNjZXNzIiwiaXNzIjoiaHR0cHM6Ly9pZC52YXRvbS5jb20iLCJhdWQiOiIzSDVxcHlpUXU5In0.EsPZX_kNSxQ08CkrYO3qPBZjckyfrn-rZAdahTg--LJZJJXxDHAPreyIc4KxN3wJ19AF7hy0bQrwXt3bbYKELJMbSIkIb7tduV9-0JucwB5VvvTf_fT_QfItaa1bSfep5F_JtckYOc80v2tXbKXt4At8BZHRzfw8cCCu0uB-pY3zKTr5OuWwsX9Bvjm4Et5LZzT6DDyrN7nvCGWzxaekCtNzhsH8FExWbsHWNTjZIG7IpnrxDQmjmYJHyldhcdNVjbbH4qWLddaywLuMsb9Kq6nMRzOHZzibTop5Aa3lcRgaHJZwCss1OgPOjQxLWcEUQfmmifH0AHW-8_POhvoZEw",
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
