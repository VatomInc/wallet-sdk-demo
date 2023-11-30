import 'package:flutter/material.dart';
import 'package:vatom_flutter/vatom_classes.dart';
import 'package:vatom_flutter/vatom_wallet.dart';

// import 'package:my_app/gradient_color.dart';

main() {
  final vatomKey = GlobalKey<VatomWalletState>();

  final VatomWallet wallet = VatomWallet(
    key: vatomKey,
    businessId: "dZCHAOE76T",

    accessToken:
        "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Imw0Mjd4WnJxNjJlR0xhS0hhc0d0bkkyZ1JZVjF3c0VUUm0weDlDcEZiOWsifQ.eyJ1cm46dmF0b21pbmM6Z3Vlc3QiOmZhbHNlLCJ1cm46dmF0b21pbmM6cmVnaW9uIjoidXMtZWFzdDQuZ2NwIiwianRpIjoiUWdVWUJ3b2thZlc3VGI0cHRjdnV1Iiwic3ViIjoiMGUzN3Y5bCIsImlhdCI6MTY5OTY0MjI3MCwiZXhwIjoxNjk5NjQ1ODcwLCJzY29wZSI6Im9wZW5pZCBwcm9maWxlIGVtYWlsIG9mZmxpbmVfYWNjZXNzIiwiaXNzIjoiaHR0cHM6Ly9pZC52YXRvbS5jb20iLCJhdWQiOiI5NEpIa2RqOGpGODNqZkZGMkxJOFE0In0.QbCc2KcFKE4X5wS05BOpHytiBiEAWOsGxGz-vYDve8LQ_M0yHhk9DCvpD_VtulWwrsbUbWAw1FL1skeHv2lwM8pb67xgPvel-shCxS04FI-7pRxY9-cf_YfaEscho8BQOvFTLnhj40E-6YGITlFgxLWnQ4doisYu4gqRTXEUCflbA9Z6HMqpu85xE67sgqWWwt2YSCBOYNEa0dOYeMbL82E4OP1nOVNtfRgt0asqUwKQg9FgleM0l55zt9iYBW_DAgt8y4rZfIui_PfQqBPRUNnaf_o6kWIMoOTwuSoPYW4dZS1UWYvL05dg2hHKmAwplWprcVnt8mfRI5vwcu8Z8A",
    config: VatomConfigFeatures(
      hideNavigation: false,
      // baseUrl: "https://0dda-201-141-20-186.ngrok-free.app/"
    ),
    // config: VatomConfigFeatures(
    //   hideNavigation: false,
    //   hideTokenActions: true,
    //   disableNewTokenToast: true,
    //   baseUrl: "https://0dda-201-141-20-186.ngrok-free.app/",
    //   scanner: ScannerFeatures(enabled: false),
    //   pageConfig: PageConfig(
    //     theme: PageTheme(
    //         header: PageThemeHeader(
    //             logo: "https://resources.vatom.com/a8BxS4bNj9/UR_Logo.png"),
    //         iconTitle: PageThemeIconTitle(),
    //         icon: PageThemeIcon(),
    //         main: PageThemeMain(),
    //         emptyState: PageThemeEmptyState(),
    //         mode: "dark",
    //         pageTheme: "dark"),
    //     text: PageText(emptyState: ""),
    //     features: PageFeatures(
    //         notifications: PageFeaturesNotifications(),
    //         card: PageFeaturesCard(),
    //         footer: PageFeaturesFooter(enabled: true, icons: [
    //           PageFeaturesFooterIcon(
    //               src: "https:sites.vatom.com/a8BxS4bNj9",
    //               title: "Home",
    //               id: "home")
    //         ]),
    //         vatom: PageFeaturesVatom()),
    //   ),
    // ),
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
                      var t = await vatomKey.currentState?.getTabs();
                      print("TABS $t");
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
                      await vatomKey.currentState?.navigateToTab("Wallet");
                    },
                    child: Text('Wallet'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await vatomKey.currentState?.navigateToTab("Map");
                    },
                    child: Text('Map'),
                  )
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
