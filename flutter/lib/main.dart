import 'package:flutter/material.dart';
import 'package:vatom_wallet_sdk/Nav.dart';
import 'package:vatom_wallet_sdk/Singleton.dart';
import 'package:vatom_wallet_sdk/wallet/vatom_wallet.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vatom Wallet',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: TapNavigator(),
    );
  }
}
