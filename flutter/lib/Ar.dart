import 'package:flutter/material.dart';
import 'package:vatom_flutter/VatomController.dart';

// }

class Ar extends StatefulWidget {
  final VatomWalletController? walletController;
  const Ar({Key? key, required this.walletController}) : super(key: key);

  @override
  _ArState createState() => _ArState();
}

class _ArState extends State<Ar> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    widget.walletController?.linkTo("/ar");
  }

  @override
  void dispose() {
    // Aquí puedes poner el código que deseas ejecutar justo antes de que la pantalla cambie.
    print('La pantalla está a punto de cambiar.');
    widget.walletController?.linkTo("/");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: Stack(
              children: [
                widget.walletController?.wallet ??
                    const Center(child: CircularProgressIndicator()),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
