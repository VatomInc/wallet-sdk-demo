import 'package:flutter/material.dart';
import 'package:vatom_wallet_sdk/wallet/vatom_classes.dart';
import 'package:vatom_wallet_sdk/wallet/vatom_wallet.dart';

void showActionSheetNewVatom(BuildContext context) {
  late VatomWallet newWallet;

  String businessId = "jwUipscNvd";
  String campaignId = "rNFOhz1pUS";
  String objectDefinitionId = "Bl50jKxgg0";

  String url =
      "/b/$businessId/find-token?campaignId=$campaignId&objectDefinitionId=$objectDefinitionId&autoClaim=true&sync=true&forceAcquire=false&login=1";

  newWallet = VatomWallet(
    accessToken:
        "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Imw0Mjd4WnJxNjJlR0xhS0hhc0d0bkkyZ1JZVjF3c0VUUm0weDlDcEZiOWsifQ.eyJ1cm46dmF0b21pbmM6bG9nZ2VkLWluLXZpYSI6Im1hZ2ljLWNvZGUiLCJ1cm46dmF0b21pbmM6Z3Vlc3QiOmZhbHNlLCJ1cm46dmF0b21pbmM6cmVnaW9uIjoidXMtZWFzdDQuZ2NwIiwianRpIjoiS05HcFMybU5FclhOSVNyNTNDNDk1Iiwic3ViIjoiMGUzN3Y5bCIsImlhdCI6MTcyNjc3MzI1MCwiZXhwIjoxNzI2Nzc2ODUwLCJzY29wZSI6Im9wZW5pZCBwcm9maWxlIGVtYWlsIG9mZmxpbmVfYWNjZXNzIiwiaXNzIjoiaHR0cHM6Ly9pZC52YXRvbS5jb20iLCJhdWQiOiI5NEpIa2RqOGpGODNqZkZGMkxJOFE0In0.UjgWbRn9bHcBTi1AVuzdLah0VXqvs9YJzdbr8pCTBJN9R-_f_kKgW_6SgT_qNtLFUHVbkO_5_J4IHb2kL5sF4mPaO6LEKr5eUsWph60pa_CRc_iokl0KYKhLmRvYeUnDWm3bXuQ4b6I9X7QPSrBtwfT1DPMKl7c8hyPDNy_4u6bxyWjphkACJHlb99roXdNHkZH51_AVxeaFL5mEt_hq0_E1qDL-pqQllLNUQgxE4v6UbiUCYZ5yiJgl8hvECBzMoEllQjJIvI_zNnoN5YgBxUvc1SurF792H1ZMMRYJ-L5cezt_SWupaTX2gWvA525PmmuMKjLT7rfvVO0LXa4Lmg",
    // onInventoryUpdate: invUpdated,
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
      hideDrawer: true,
      hideNavigation: true,

      path: url,
      // path: "/map",

      walletConfig: AppConfiguration(
        features: FeaturesConfig(
          screensConfig: ScreensConfigSchema(
            wallet: WalletSchema(
              showInventory: true,
              scanner: false,
              emptyStateImage:
                  "https://images.ctfassets.net/yaek2eheu5pz/65TR437juOMO59Z2taHbln/d2882ed86c1e42e8f58a12d3d8180d0a/splash_brand_logo_large.png",
              emptyStateTitle: "No Coupons Available!",
              emptyStateMessage: " ",
              inventoryFilter: 'Coupons',
            ),
          ),
          hideCloseButtonOnNft: false,
          customActionBtn: IconConfig(
            icon:
                "https://resources.vatom.com/Cox1qh6ggb/joy_action_button.png",
            style: {"height": "40px", "width": "120px", "objectFit": 'contain'},
          ),
          customActions: List<ActionConfig>.from(
            [
              ActionConfig(
                action: "goamaGame:getVatom",
                text: "Play Game",
                style: {
                  "color": '#1443FF',
                  "fontSize": "16px",
                  "fontWeight": "100",
                  "marginBottom": "10"
                },
              ),
            ],
          ),
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

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          return FractionallySizedBox(
            heightFactor: 0.9,
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  // ListTile(
                  //   leading: const Icon(Icons.cancel),
                  //   title: const Text('Close'),
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //   },
                  // ),
                  Expanded(
                    child: newWallet,
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
