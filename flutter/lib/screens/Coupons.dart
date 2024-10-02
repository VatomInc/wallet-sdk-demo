import 'package:flutter/material.dart';
import 'package:vatom_wallet/Vatom/Vatom.dart';
import 'package:vatom_wallet/main.dart';
import 'package:vatom_wallet_sdk/vatom_wallet_sdk.dart';

class ThirdScreen extends StatelessWidget {
  void _showActionSheet(BuildContext context, String objectDefinitionId) {
    VatomWallet wallet = getSingletonwalletInstance();
    String campaignId = getcampaignId();
    String _bid = getBusinessId();

    String url =
        "/b/$_bid/find-token?campaignId=${campaignId}&objectDefinitionId=$objectDefinitionId&autoClaim=true&sync=true&forceAcquire=false&login=1";

    wallet.linkTo(url, forceNavigation: true);

    wallet.on(
      "closeVatom",
      (data) => {print("VATOM.LOG: closeVatom"), Navigator.pop(context)},
    );

    wallet.on(
      "viewer.view.close",
      (data) => {print("VATOM.LOG: viewer.view.close"), Navigator.pop(context)},
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return FractionallySizedBox(
              heightFactor: 0.9,
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: wallet,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Texto centrado
            Text(
              'Esta pantalla debe disparar el loadRquest',
              style: TextStyle(
                  fontSize: 20), // Cambia el tamaño del texto si lo deseas
            ),
            SizedBox(height: 20), // Añadir espacio entre el texto y el botón
            ElevatedButton(
              onPressed: () {
                String objectDefinitionId = "gwX4i4LKkr";
                _showActionSheet(context, objectDefinitionId);
              },
              child: const Text('3vJzWykfXB'),
            ),
          ],
        ),
      ),
    );
  }
}
