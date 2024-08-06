import 'package:flutter/material.dart';
import 'package:vatom_flutter/VatomWallet.dart';
import 'package:vatom_wallet_sdk/vatom_wallet_sdk.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vatom Wallet Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

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
        "viewer.view.close", (data) => {print(data), Navigator.pop(context)});
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
                    ListTile(
                      leading: const Icon(Icons.cancel),
                      title: const Text('Close'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: wallet.build(context),
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
      appBar: AppBar(
        title: const Text('Vatom Wallet Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => {
                wallet.linkTo(
                    "/b/jwUipscNvd/find-token?campaignId=lDAKDnxh1j&objectDefinitionId=D4l9pLrXJr&autoClaim=true&sync=true"),
                _showActionSheet(context)
              },
              child: const Text('open D4l9pLrXJr'),
            ),
            ElevatedButton(
              onPressed: () => {
                wallet.linkTo(
                    "/b/jwUipscNvd/find-token?campaignId=lDAKDnxh1j&objectDefinitionId=Bl50jKxgg0&autoClaim=true&sync=true"),
                _showActionSheet(context)
              },
              child: const Text('open Bl50jKxgg0'),
            ),
          ],
        ),
      ),
    );
  }
}
