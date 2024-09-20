import 'dart:convert';

import 'package:vatom_wallet_sdk/wallet/vatom_classes.dart';
import 'package:vatom_wallet_sdk/wallet/vatom_wallet.dart';

VatomWallet? _walletInstance;

void invUpdated() {
  print("VATOM.LOG: onInventoryUpdate");
}

VatomWallet getSingletonwalletInstance({String? initialRoutePath}) {
  _walletInstance ??= VatomWallet(
    accessToken:
        "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Imw0Mjd4WnJxNjJlR0xhS0hhc0d0bkkyZ1JZVjF3c0VUUm0weDlDcEZiOWsifQ.eyJ1cm46dmF0b21pbmM6bG9nZ2VkLWluLXZpYSI6Im1hZ2ljLWNvZGUiLCJ1cm46dmF0b21pbmM6Z3Vlc3QiOmZhbHNlLCJ1cm46dmF0b21pbmM6cmVnaW9uIjoidXMtZWFzdDQuZ2NwIiwianRpIjoidG1MUVZ1UGxoSU82YWFTZEFEbVBFIiwic3ViIjoiMGUzN3Y5bCIsImlhdCI6MTcyNjg2NDcwMSwiZXhwIjoxNzI2ODY4MzAxLCJzY29wZSI6Im9wZW5pZCBwcm9maWxlIGVtYWlsIG9mZmxpbmVfYWNjZXNzIiwiaXNzIjoiaHR0cHM6Ly9pZC52YXRvbS5jb20iLCJhdWQiOiI5NEpIa2RqOGpGODNqZkZGMkxJOFE0In0.KBj1u3eZ7QcJ9GnJ56jTyZjde4IPXTLdwiimwuyvNyCDEYezRrViAmqMO74gvFPzuuopO-os8Nw4WAzW2N0_lyTCkCIMc-pNZjb6DeeAGF2SjctYxdh1r3ntoiCLHZwxjO987pSo2VCiNWV3PKSubi67h-1QgCLJgDvIfboNaJiJj_Y4JlK7SYUnCWr-mBBdOGlGMQ2M3s4bk1cwz6OTX3XU3RIZC-2MZZsDnIBIBmUtpSPG0ZLfoVE7US-8_Texd2grW7LgiKqGbaSCHfNoJ5z4NKHKhtWB0OuLL2aZgwCV4o8NrFt2KDicNR9ndH-3c1y1hWTDYwlJXENKtM2AHw",
    onCustomActionReceived: (data) {
      print("VATOM.LOG: onCustomActionReceived $data");
    },
    config: VatomConfigFeatures(
      systemThemeOverride: "light",
      // baseUrl: "https://wallet.vatominc.com",
      // baseUrl: "http://wallet.localhost:3000",
      hideTokenActions: false,
      disableArPickup: true,
      disableNewTokenToast: true,
      hideDrawer: false,
      hideNavigation: false,

      // path: "/b/jwUipscNvd",
      path: '/b/cPP75g52F3',
      // path: "/map",

      walletConfig: AppConfiguration(
        features: FeaturesConfig(
          screensConfig: ScreensConfigSchema(
            wallet: WalletSchema(
              // showInventory: false,
              scanner: false,
              emptyStateImage:
                  "https://images.ctfassets.net/yaek2eheu5pz/65TR437juOMO59Z2taHbln/d2882ed86c1e42e8f58a12d3d8180d0a/splash_brand_logo_large.png",
              emptyStateTitle: "No Coupons Available!",
              emptyStateMessage: " ",
              inventoryFilter: 'Coupons',
            ),
          ),
          hideCloseButtonOnNft: false,
          // customActionBtn: IconConfig(
          //   icon:
          //       "https://resources.vatom.com/Cox1qh6ggb/joy_action_button.png",
          //   style: {"height": "40px", "width": "120px", "objectFit": 'contain'},
          // ),
          // customActions: List<ActionConfig>.from(
          //   [
          //     ActionConfig(
          //       action: "goamaGame:getVatom",
          //       text: "Play Game",
          //       style: {
          //         "color": '#1443FF',
          //         "fontSize": "16px",
          //         "fontWeight": "100",
          //         "marginBottom": "10"
          //       },
          //     ),
          //   ],
          // ),
        ),
      ),
      pageConfig: PageConfig(
        features: PageFeatures(
          card: PageFeaturesCard(),
          vatom: PageFeaturesVatom(),
          icon: PageFeaturesIcon(
            badges: false,
            editions: false,
            titles: true,
          ),
        ),
      ),
      language: 'en', // Asumiendo que 'language' está definido como 'en'
      scanner: ScannerFeatures(enabled: false),
    ),
  );

  return _walletInstance!;
}
