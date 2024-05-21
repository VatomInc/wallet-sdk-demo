import 'package:flutter/material.dart';
import 'package:vatom_flutter/VatomController.dart';
import 'package:vatom_wallet_sdk/vatom_wallet_sdk.dart';

class Home extends StatelessWidget {
  String? vatomToken;
  Home({super.key, required this.vatomToken});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BottomSheetExample(
          vatomToken: vatomToken,
        ),
      ),
    );
  }
}

class BottomSheetExample extends StatelessWidget {
  String? vatomToken;
  BottomSheetExample({super.key, required this.vatomToken});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('Open AR'),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return FractionallySizedBox(
                heightFactor: 0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        child: const Text('Close BottomSheet'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Expanded(
                      child: _Ar(
                        vatomToken: vatomToken,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _Ar extends StatelessWidget {
  String? vatomToken;
  _Ar({super.key, required this.vatomToken});

  @override
  Widget build(BuildContext context) {
    final vatomWallet = VatomWallet(
      accessToken: vatomToken,
      config: VatomConfigFeatures(
        path: "/ar",
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: 400, // Ancho deseado
          height: 600, // Alto deseado
          child: Stack(
            children: [
              vatomWallet ?? const Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }
}
