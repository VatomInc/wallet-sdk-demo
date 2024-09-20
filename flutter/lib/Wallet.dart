import 'package:flutter/material.dart';
import 'package:vatom_wallet_sdk/Singleton.dart';
import 'package:vatom_wallet_sdk/wallet/vatom_classes.dart';
import 'package:vatom_wallet_sdk/wallet/vatom_wallet.dart';

class Wallet extends StatefulWidget {
  @override
  _Wallet createState() => _Wallet();
}

class _Wallet extends State<Wallet> {
  late VatomWallet wallet;

  @override
  void initState() {
    super.initState();
    wallet = getSingletonwalletInstance();

    // wallet = VatomWallet(
    //   accessToken:
    //       // "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Imw0Mjd4WnJxNjJlR0xhS0hhc0d0bkkyZ1JZVjF3c0VUUm0weDlDcEZiOWsifQ.eyJhY3QiOnsiYXVkIjoiOTRKSGtkajhqRjgzamZGRjJMSThRNCJ9LCJ1cm46dmF0b21pbmM6Z3Vlc3QiOmZhbHNlLCJ1cm46dmF0b21pbmM6cmVnaW9uIjoidXMtZWFzdDQuZ2NwIiwianRpIjoia2FsdmdBRFA5ZFZuTDZfdDBfdEFDIiwic3ViIjoiZDRhYmprNSIsImlhdCI6MTcyNDI1MTU0OSwiZXhwIjoxNzI0MjU1MTQ5LCJzY29wZSI6Im9mZmxpbmUgcHJvZmlsZSIsImlzcyI6Imh0dHBzOi8vaWQudmF0b20uY29tIiwiYXVkIjoid2FsbGV0LXJuIn0.I9F9Ga74NB8R5YqvUP4P13EQwNvE5Ak7RaEZAP76L-HZ55C0Q5Uj-01GOXBrhB3hxFhTa8aShH0BGHIfM6a9UNznhKRfYkrmnCNWlDnIQyFNb22BUEx82CvvXyqt2lEQlNaBNDOVw1KWG2ZFO_HUPquvAPVpGIaIDrzpAjDT7BrVR_gcTrGs_5YXNHjalEHM2hRfoXvdHx8luDCbP9EWanhSZGqM0xUbjEKYOa-6AFBmVdjR94HrYiaupkVhCysySVwLK5V-1L5MKJblYDjXjX_ncqTmHFw6pPnRyp0z_MXXTyX58lPOhawxkLQJJK0kKJpr1nAuFGdMwadauwBPyQ",
    //       "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Imw0Mjd4WnJxNjJlR0xhS0hhc0d0bkkyZ1JZVjF3c0VUUm0weDlDcEZiOWsifQ.eyJ1cm46dmF0b21pbmM6Z3Vlc3QiOmZhbHNlLCJ1cm46dmF0b21pbmM6cmVnaW9uIjoidXMtZWFzdDQuZ2NwIiwianRpIjoiN3lSaTdpNlhuSnFGMHRhYmNIRnNkIiwic3ViIjoiMGUzN3Y5bCIsImlhdCI6MTcyNDcyMDA2NiwiZXhwIjoxNzI0NzIzNjY2LCJzY29wZSI6Im9wZW5pZCBwcm9maWxlIGVtYWlsIG9mZmxpbmVfYWNjZXNzIiwiaXNzIjoiaHR0cHM6Ly9pZC52YXRvbS5jb20iLCJhdWQiOiI5NEpIa2RqOGpGODNqZkZGMkxJOFE0In0.Yyrl04N0bTyhcUZcHg_DafU-MOla_MJXJ9tZK2sVh7qT88IofpPWr9ROlwUQVoj_joJlkTnR7OTbhr1aqifQx1DtLw5YghRJ9CPhHJYmF7Qj5QYlcTUUiYWR2IAc52lk41vGtJzrL-esHFLvkjq7yPEUic3x1A2_D1bVhaRGXH9SmqXvPflWE9-R9CvtumP4HyqtqTA2ihTytRuxj46w-BbrgaIZ9aTehsGe5R3IcDTvPSi01vPL8y1c6mRUIbswVNyD8_z6MS0UkDFgrD3dAH_BZCZwfDtTDcZQgwMI1ooAz-ktcO5GQk7XKnFneIs6X8B4UUn8KNV8pJf77HwSow",
    //   refreshToken: "jzW4oEeZy2L7p3nEd1HUURna4RWXLrLR-4vToSqd0GC",
    //   config: VatomConfigFeatures(
    //     baseUrl: "https://wallet.vatom.com",
    //     hideTokenActions: false,
    //     disableArPickup: false,
    //     disableNewTokenToast: false,
    //     hideDrawer: false,
    //     hideNavigation: false,
    //     systemThemeOverride: "light",
    //     path: "/b/jwUipscNvd",
    //     emptyStateTitle: "No Coupons Available!",
    //     emptyStateMessage: " ",
    //     emptyStateImage:
    //         "https://images.ctfassets.net/yaek2eheu5pz/65TR437juOMO59Z2taHbln/d2882ed86c1e42e8f58a12d3d8180d0a/splash_brand_logo_large.png",

    //     walletConfig: AppConfiguration(
    //       features: FeaturesConfig(
    //           hideCloseButtonOnNft: false, inventoryFilter: 'Coupons'),
    //     ),
    //     pageConfig: PageConfig(
    //       features: PageFeatures(
    //         card: PageFeaturesCard(),
    //         vatom: PageFeaturesVatom(),
    //         icon: PageFeaturesIcon(
    //           badges: false,
    //           editions: false,
    //           titles: true,
    //         ),
    //       ),
    //     ),
    //     language: 'en', // Asumiendo que 'language' está definido como 'en'
    //     scanner: ScannerFeatures(enabled: false),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: wallet,
      ),
    );
  }
}
