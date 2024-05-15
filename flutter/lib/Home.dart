import 'package:flutter/material.dart';
import 'package:vatom_flutter/VatomController.dart';

class Home extends StatelessWidget {
  final VatomWalletController? walletController;
  const Home({super.key, required this.walletController});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('this is the home page'),
      ),
    );
  }
}
