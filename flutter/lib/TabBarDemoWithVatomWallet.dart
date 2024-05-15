import 'package:flutter/material.dart';
import 'package:vatom_flutter/Ar.dart';
import 'package:vatom_flutter/Home.dart';
import 'package:vatom_flutter/VatomController.dart';
import 'package:vatom_flutter/Wallet.dart';

class TabBarDemoWithVatomWallet extends StatelessWidget {
  const TabBarDemoWithVatomWallet({Key? key}) : super(key: key);

  final vatomToken =
      "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Imw0Mjd4WnJxNjJlR0xhS0hhc0d0bkkyZ1JZVjF3c0VUUm0weDlDcEZiOWsifQ.eyJ1cm46dmF0b21pbmM6Z3Vlc3QiOmZhbHNlLCJ1cm46dmF0b21pbmM6cmVnaW9uIjoidXMtZWFzdDQuZ2NwIiwianRpIjoiVEpwOVJUTWgwaTI1M1BWNHZLSFd2Iiwic3ViIjoiMGUzN3Y5bCIsImlhdCI6MTcxNTc5NzgzMSwiZXhwIjoxNzE1ODAxNDMxLCJzY29wZSI6Im9mZmxpbmUgcHJvZmlsZSIsImlzcyI6Imh0dHBzOi8vaWQudmF0b20uY29tIiwiYXVkIjoid2FsbGV0LXJuIn0.Tn5pqMQftiuJCdvRU6yGeL9qYqAvj0EqpoHHLk4XlvW8IqOB6VTPfhRAIc8h8PTny4vwIP4Pt9KGtk8XmSNnQtHUnESeKRmp7Rk-PnzrnNSebm8x_Qbgf6owOJL55N2qveZxxMryGG7c4EdTLwHO_DX_TGXphupUu0VhS12tEXavJw3sgeALjJzroYOzAioODpFutMFFUZPUsJ-uVxu-2G2BXnF5p51Ycxs0NAVzg3b88WiUUEq8QNZaNSKk3bFOCvuxeaH8IDlyWMBiYXR9lVm8NYsqv4UUrK0aBViCEjpk8ygGpghA6VosT_8_-d4ofWu4gTF9YSjqIU_7vyBs0g";
  @override
  Widget build(BuildContext context) {
    final VatomWalletController walletController =
        VatomWalletController(vatomToken);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.wallet)),
              Tab(icon: Icon(Icons.camera)),
            ],
          ),
          title: Text('Vatom SDK Demo'),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Home(
              walletController: walletController,
            ),
            Wallet(
              walletController: walletController,
            ),
            Ar(
              walletController: walletController,
            )
          ],
        ),
      ),
    );
  }
}
