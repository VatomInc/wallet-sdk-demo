import 'dart:convert';

import 'package:vatom_wallet/main.dart';
import 'package:vatom_wallet_sdk/vatom_wallet_sdk.dart';

VatomWallet? _walletInstance;

void invUpdated() {
  print("VATOM.LOG: onInventoryUpdate");
}

VatomWallet getSingletonwalletInstance() {
  final String bUrl = getBaseUrl();
  final String _bid = getBusinessId();
  final String at = getAt();

  _walletInstance ??= VatomWallet(
    accessToken: at,
    config: VatomConfigFeatures(
      systemThemeOverride: "light",
      baseUrl: bUrl,
      hideTokenActions: false,
      disableArPickup: true,
      disableNewTokenToast: true,
      hideDrawer: true,
      hideNavigation: true,

      path: '/b/$_bid',

      walletConfig: AppConfiguration(
        features: FeaturesConfig(
          hideCloseButtonOnNft: false,
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
