import 'package:flutter/material.dart';
import 'package:vatom_wallet/main.dart';
import 'package:vatom_wallet_sdk/vatom_wallet_sdk.dart';

void showActionSheetNewVatom(
  BuildContext context,
  String? objectDefinitionId,
) {
  print("VATOM.LOG: init new instance");
  late VatomWallet newWallet;

  String at = getAt();
  String businessId = getBusinessId();
  String campaignId = getcampaignId();

  String url =
      "/b/$businessId/find-token?campaignId=$campaignId&objectDefinitionId=$objectDefinitionId&autoClaim=true&sync=true&forceAcquire=false&login=1";

  newWallet = VatomWallet(
    accessToken: at,
    config: VatomConfigFeatures(
      systemThemeOverride: "light",
      hideTokenActions: false,
      disableArPickup: true,
      disableNewTokenToast: true,
      hideDrawer: true,
      hideNavigation: true,
      path: url,
      walletConfig: AppConfiguration(
        features: FeaturesConfig(
          hideCloseButtonOnNft: false,
          screensConfig: ScreensConfigSchema(
              wallet: WalletSchema(
                showInventory: false,
                scanner: false,
                emptyStateImage:
                    "https://images.ctfassets.net/yaek2eheu5pz/65TR437juOMO59Z2taHbln/d2882ed86c1e42e8f58a12d3d8180d0a/splash_brand_logo_large.png",
                emptyStateTitle: "No Coupons Available!",
                emptyStateMessage: " ",
                inventoryFilter: 'Coupons',
              ),
              nftDetalSchema: NftDetalSchema(hideTokenActions: true)),
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
      language: 'en',
      scanner: ScannerFeatures(enabled: false),
    ),
  );

  newWallet.on(
    "closeVatom",
    (x) => {Navigator.pop(context)},
  );

  newWallet.on(
    "viewer.view.close",
    (x) => {Navigator.pop(context)},
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
