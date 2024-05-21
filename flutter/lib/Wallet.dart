import 'package:flutter/material.dart';
import 'package:vatom_flutter/VatomController.dart';
import 'package:vatom_wallet_sdk/vatom_wallet_sdk.dart';

class Wallet extends StatelessWidget {
  String? vatomToken;
  Wallet({super.key, required this.vatomToken});

  @override
  Widget build(BuildContext context) {
    final vatomWallet = VatomWallet(
      accessToken: vatomToken,
      config: VatomConfigFeatures(
        path: "/",
        hideDrawer: false,
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: Stack(
              children: [
                vatomWallet ?? const Center(child: CircularProgressIndicator()),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
