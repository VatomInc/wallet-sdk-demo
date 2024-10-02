import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vatom_wallet/ShowNewInstance.dart';
import 'package:vatom_wallet/Vatom/Vatom.dart';
import 'package:vatom_wallet/main.dart';
import 'package:vatom_wallet_sdk/vatom_wallet_sdk.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  late VatomWallet wallet;
  late String? _bid;

  @override
  void initState() {
    super.initState();
    wallet = getSingletonwalletInstance();
    _bid = getBusinessId();

    wallet.on(
      "closeVatom",
      (data) => {print("VATOM.LOG: closeVatom"), Navigator.pop(context)},
    );

    wallet.on(
      "viewer.view.close",
      (data) => {print("VATOM.LOG: viewer.view.close"), Navigator.pop(context)},
    );

    wallet.on("findToken", (data) {
      if (data.containsKey("payload") && data["payload"].containsKey("error")) {
        print("VATOM.LOG: findToken");
        Navigator.pop(context);
      }
    });
  }

  void _showActionSheet(BuildContext context, String objectDefinitionId) {
    String campaignId = getcampaignId();
    String url =
        "/b/$_bid/find-token?campaignId=${campaignId}&objectDefinitionId=$objectDefinitionId&autoClaim=true&sync=true&forceAcquire=false&login=1";

    wallet.linkTo(url);

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
            ElevatedButton(
              onPressed: () {
                String objectDefinitionId = "gwX4i4LKkr";

                _showActionSheet(context, objectDefinitionId);
              },
              child: const Text('3vJzWykfXB'),
            ),
            ElevatedButton(
              onPressed: () => {showActionSheetNewVatom(context, "gwX4i4LKkr")},
              child: const Text('OPEN NEW INSTANCE'),
            ),
          ],
        ),
      ),
    );
  }
}
