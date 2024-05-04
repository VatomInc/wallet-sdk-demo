import 'package:flutter/material.dart';
import 'package:vatom_flutter/vatom_classes.dart';
import 'package:vatom_flutter/vatom_wallet.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();

  final VatomWallet wallet = VatomWallet(
    accessToken:
        "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Imw0Mjd4WnJxNjJlR0xhS0hhc0d0bkkyZ1JZVjF3c0VUUm0weDlDcEZiOWsifQ.eyJ1cm46dmF0b21pbmM6Z3Vlc3QiOmZhbHNlLCJ1cm46dmF0b21pbmM6cmVnaW9uIjoidXMtZWFzdDQuZ2NwIiwianRpIjoiNV9zZ1lVSmJVVWZkTG8wM3lFZEdoIiwic3ViIjoiMGUzN3Y5bCIsImlhdCI6MTcxNDc2OTM1NCwiZXhwIjoxNzE0NzcyOTU0LCJzY29wZSI6Im9wZW5pZCBwcm9maWxlIGVtYWlsIG9mZmxpbmVfYWNjZXNzIiwiaXNzIjoiaHR0cHM6Ly9pZC52YXRvbS5jb20iLCJhdWQiOiI5NEpIa2RqOGpGODNqZkZGMkxJOFE0In0.KdS6s_GjRrlqddct5-Q19JeQEx6Qr1TCfxS4LjBPcbijHkAJ5n_e4JmE_J_4Bc2Z7kvgjXXMo-00MsP5GoH2A79tiBhWqkn1p9uEjyFulpYPvhsGLzCRqB5uVRguSib622XPMzhFWMW43pgkk-NGuhejqk_trgcxCM-5xIhx3yX30jOxzdD5Schk_boyC580USruwBfYN8zZjr9C82R0lIVqxDnyX0CN8OaNlfhiRSc3Es6kpL6C_-XZuOV-gVip0gzqnteGoza_BySFb9v7HknZLmW4ROK0hn-wNOBjxr2PXOttk5fE3m7hzoyGEKTdGVnpet-h906ODq_ko7E22g",
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
                      // await wallet.openCommunity('sahMOa1qQR',
                      //     roomId: '!EcINyJyITqdmqVEAVe%3Avatom.com');
                      var tabs = await wallet.getCurrentUser();
                      print(tabs?.toJson());
                    },
                    child: Text('getCurrentUser'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await wallet.navigateToTab("Connect");
                    },
                    child: Text('Connect'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await wallet.navigateToTab("map");
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
