import 'package:flutter/material.dart';
import 'package:vatom_flutter/VatomController.dart';

class Home extends StatelessWidget {
  final VatomWalletController? walletController;
  const Home({super.key, required this.walletController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BottomSheetExample(
          walletController: walletController,
        ),
      ),
    );
  }
}

class BottomSheetExample extends StatelessWidget {
  final VatomWalletController? walletController;
  const BottomSheetExample({super.key, required this.walletController});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('Open AR'),
        onPressed: () {
          walletController?.linkTo("/ar");
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
                          walletController?.linkTo("/");
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Expanded(
                      child: _Ar(
                        walletController: walletController,
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
  final VatomWalletController? walletController;
  const _Ar({super.key, required this.walletController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: 400, // Ancho deseado
          height: 600, // Alto deseado
          child: Stack(
            children: [
              walletController?.wallet ??
                  const Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }
}
