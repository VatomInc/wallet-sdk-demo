import 'package:flutter/cupertino.dart';
import 'package:vatom_wallet_sdk/vatom_wallet_sdk.dart';

class VatomWalletController {
  late VatomWallet wallet;

  VatomWalletController(
    String? vatomToken,
  ) {
    print("VatomWalletController: $vatomToken");
    wallet = VatomWallet(
      accessToken: vatomToken,
      config: VatomConfigFeatures(
        emptyStateImage:
            "https://www.vatom.com/wp-content/uploads/2022/04/VATOM_Home_Twitter-1.jpg",
        scanner: ScannerFeatures(enabled: false),
      ),
    );
  }

  Future<void> linkTo(String? url) async {
    if (url != null) {
      await wallet.linkTo(url);
    }
  }
}
