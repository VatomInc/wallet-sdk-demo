import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vatom_wallet/ShowNewInstance.dart';
import 'package:vatom_wallet/Vatom/Vatom.dart';
import 'package:vatom_wallet_sdk/vatom_wallet_sdk.dart';

class MyHomePage extends StatefulWidget {
  final String? at;
  final String? baseUrl;
  final String? businessId;
  final String? campaingId;

  const MyHomePage(
      {Key? key, this.at, this.baseUrl, this.businessId, this.campaingId})
      : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late VatomWallet wallet;

  @override
  void initState() {
    super.initState();
    wallet = getSingletonwalletInstance(
        at: widget.at, baseUrl: widget.baseUrl, businessId: widget.businessId);

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

  void _showActionSheet(BuildContext context, String businessId,
      String campaignId, String objectDefinitionId) {
    String url =
        "/b/$businessId/find-token?campaignId=${widget.campaingId}&objectDefinitionId=$objectDefinitionId&autoClaim=true&sync=true&forceAcquire=false&login=1";

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
                String businessId = "cPP75g52F3";
                String campaignId = "NxY6V4ZkZH";
                String objectDefinitionId = "euW2sZY4cz";

                _showActionSheet(
                    context, businessId, campaignId, objectDefinitionId);
              },
              child: const Text('euW2sZY4cz'),
            ),
            ElevatedButton(
              onPressed: () {
                String businessId = "dALCDZAzCA";
                String campaignId = "70nIsRCpgp";
                String objectDefinitionId = "gwX4i4LKkr";

                _showActionSheet(
                    context, businessId, campaignId, objectDefinitionId);
              },
              child: const Text('gwX4i4LKkr'),
            ),
            ElevatedButton(
              onPressed: () async {
                showActionSheetNewVatom(context, widget.at, widget.businessId,
                    widget.campaingId, "gwX4i4LKkr");
              },
              child: const Text('OPEN FIND NEW'),
            ),
          ],
        ),
      ),
    );
  }
}
