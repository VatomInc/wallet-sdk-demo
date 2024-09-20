import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vatom_wallet_sdk/ShowNewInstance.dart';
import 'package:vatom_wallet_sdk/Singleton.dart';
import 'package:vatom_wallet_sdk/wallet/vatom_classes.dart';
import 'package:vatom_wallet_sdk/wallet/vatom_wallet.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late VatomWallet wallet;

  @override
  void initState() {
    super.initState();
    wallet = getSingletonwalletInstance();

    wallet.on(
      "closeVatom",
      (data) =>
          {print("VATOM.LOG: closeVatom data $data"), Navigator.pop(context)},
    );

    wallet.on(
      "viewer.view.close",
      (data) =>
          {print("VATOM.LOG: viewer.view.close $data"), Navigator.pop(context)},
    );

    wallet.on("findToken", (data) {
      if (data.containsKey("payload") && data["payload"].containsKey("error")) {
        print("VATOM.LOG: findToken");
        Navigator.pop(context);
      }
    });
  }

  void _showActionSheet(BuildContext context) {
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
                    // ListTile(
                    //   leading: const Icon(Icons.cancel),
                    //   title: const Text('Close'),
                    //   onTap: () {
                    //     Navigator.pop(context);
                    //   },
                    // ),
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
                // String objectDefinitionId = "twfcPupoq1";
                String objectDefinitionId = "euW2sZY4cz";

                String url =
                    "/b/$businessId/find-token?campaignId=$campaignId&objectDefinitionId=$objectDefinitionId&autoClaim=true&sync=true&forceAcquire=false&login=1";

                wallet.linkTo(url);

                _showActionSheet(context);
              },
              child: const Text('BAD'),
            ),
            ElevatedButton(
              onPressed: () {
                String businessId = "dALCDZAzCA";
                String campaignId = "70nIsRCpgp";
                String objectDefinitionId = "gwX4i4LKkr";

                String url =
                    "/b/$businessId/find-token?campaignId=$campaignId&objectDefinitionId=$objectDefinitionId&autoClaim=true&sync=true&forceAcquire=false&login=1";

                wallet.linkTo(url);
                _showActionSheet(context);
              },
              child: const Text('gwX4i4LKkr'),
            ),
            ElevatedButton(
              onPressed: () {
                String businessId = "jwUipscNvd";
                String campaignId = "rNFOhz1pUS";
                String objectDefinitionId = "rNFOhz1pUS";

                String url =
                    "/b/$businessId/find-token?campaignId=$campaignId&objectDefinitionId=$objectDefinitionId&autoClaim=true&sync=true&forceAcquire=false&login=1";
                wallet.linkTo(url);
                _showActionSheet(context);
              },
              child: const Text('rNFOhz1pUS'),
            ),
            ElevatedButton(
              onPressed: () async {
                dynamic user = await wallet.getCurrentUser();
                print("VATOM.LOG USER: ${user.email}");
              },
              child: const Text('user'),
            ),
            ElevatedButton(
              onPressed: () async {
                showActionSheetNewVatom(context);
              },
              child: const Text('OPEN FIND NEW'),
            ),
          ],
        ),
      ),
    );
  }
}
