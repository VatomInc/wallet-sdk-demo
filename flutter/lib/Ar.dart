import 'package:flutter/material.dart';
import 'package:vatom_flutter/VatomController.dart';
import 'package:vatom_wallet_sdk/vatom_wallet_sdk.dart';

// }

class Ar extends StatefulWidget {
  String? vatomToken;
  Ar({Key? key, required this.vatomToken}) : super(key: key);

  @override
  _ArState createState() => _ArState();
}

class _ArState extends State<Ar> {
  @override
  Widget build(BuildContext context) {
    final vatomWallet = VatomWallet(
      accessToken: widget.vatomToken,
      config: VatomConfigFeatures(path: "/ar"),
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
