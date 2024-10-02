import 'package:flutter/material.dart';
import 'package:vatom_wallet/Vatom/Vatom.dart';
import 'package:vatom_wallet_sdk/vatom_wallet_sdk.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);
  @override
  _Wallet createState() => _Wallet();
}

class _Wallet extends State<Wallet> {
  late VatomWallet wallet;

  @override
  void initState() {
    super.initState();
    wallet = getSingletonwalletInstance();
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
