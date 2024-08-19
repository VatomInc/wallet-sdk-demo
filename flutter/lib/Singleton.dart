import 'package:vatom_wallet_sdk/vatom_classes.dart';
import 'package:vatom_wallet_sdk/vatom_wallet.dart';

VatomWallet? _walletInstance;

VatomWallet getSingletonwalletInstance({String? initialRoutePath}) {
  _walletInstance ??= VatomWallet(
    accessToken:
        "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Imw0Mjd4WnJxNjJlR0xhS0hhc0d0bkkyZ1JZVjF3c0VUUm0weDlDcEZiOWsifQ.eyJ1cm46dmF0b21pbmM6bG9nZ2VkLWluLXZpYSI6IiIsInVybjp2YXRvbWluYzpndWVzdCI6ZmFsc2UsInVybjp2YXRvbWluYzpyZWdpb24iOiJ1cy1lYXN0NC5nY3AiLCJqdGkiOiJPNDR3U0EtREhFa1V6bndmWVZKaWYiLCJzdWIiOiJjemI1dnR6IiwiaWF0IjoxNzI0MTA1NjcxLCJleHAiOjE3MjQxMDkyNzEsInNjb3BlIjoib3BlbmlkIHByb2ZpbGUgZW1haWwgb2ZmbGluZV9hY2Nlc3MiLCJpc3MiOiJodHRwczovL2lkLnZhdG9tLmNvbSIsImF1ZCI6Ijk0SkhrZGo4akY4M2pmRkYyTEk4UTQifQ.nKJ99eckqnLfjTqTLyr31mQIYosjAb7PptofDwqO5C7waTbXGo9yT_l4yI5Mhx9IFi04MdLBkfl7gJqHW8eDV34bCla-IOsgnRZIZ9PbkukAeLq3BUWl9UWIK2uK_J4hvz7LKwiNif6fWU4pY3mX6PxQklUkSXsfCyy3IbZniFsjf_QPvNsZrSp246YzWW24F0D485y0hgZUvTcjqXXLYKNGWh7XPUXt8ZdPbFmevA0wGVemOH8vq7ZAN9me0oET-nfkkn_Nwk8bJlguo02qsXHWH2K3oO9N_5sM3mF0Q4XtSE-IV_JxxYJ2oE1NJ7fxydrL6BEh0Uo8OZfnPnV2nA",
    initialRoute: initialRoutePath ?? _walletInstance?.initialRoute,
    config: VatomConfigFeatures(
      baseUrl: "http://wallet.localhost:3000",
      // baseUrl: "http://wallet.vatom.com",
      hideTokenActions: true,
      disableArPickup: true,
      disableNewTokenToast: true,
      hideDrawer: true,
      hideNavigation: true,
      systemThemeOverride: "light",
      path: "/b/jwUipscNvd",
      walletConfig: AppConfiguration(
        features: FeaturesConfig(
          hideCloseButtonOnNft: false,
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
