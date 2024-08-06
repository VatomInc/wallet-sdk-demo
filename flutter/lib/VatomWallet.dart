import 'package:vatom_wallet_sdk/vatom_wallet_sdk.dart';

VatomWallet? _walletInstance;

VatomWallet getSingletonwalletInstance({String? initialRoutePath}) {
  _walletInstance ??= VatomWallet(
    accessToken: "ACCES TOKEN HERE",
    initialRoute: initialRoutePath ?? _walletInstance?.initialRoute,
    config: VatomConfigFeatures(
      baseUrl: "http://wallet.vatominc.com",
      hideTokenActions: true,
      disableArPickup: true,
      disableNewTokenToast: true,
      hideDrawer: true,
      hideNavigation: true,
      path: "/b/jwUipscNvd",
      walletConfig: AppConfiguration(
        features: FeaturesConfig(
          hideCloseButtonOnNft: true,
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
