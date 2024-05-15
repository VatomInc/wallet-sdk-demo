import 'package:flutter/material.dart';
import 'package:vatom_flutter/VatomController.dart';

class Wallet extends StatelessWidget {
  final VatomWalletController? walletController;
  const Wallet({super.key, required this.walletController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: Stack(
              children: [
                walletController?.wallet ??
                    const Center(child: CircularProgressIndicator()),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
