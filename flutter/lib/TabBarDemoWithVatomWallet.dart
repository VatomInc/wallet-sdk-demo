import 'package:flutter/material.dart';
import 'package:vatom_flutter/Ar.dart';
import 'package:vatom_flutter/Home.dart';
import 'package:vatom_flutter/VatomController.dart';
import 'package:vatom_flutter/Wallet.dart';

class TabBarDemoWithVatomWallet extends StatelessWidget {
  const TabBarDemoWithVatomWallet({Key? key}) : super(key: key);

  final vatomToken =
      "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Imw0Mjd4WnJxNjJlR0xhS0hhc0d0bkkyZ1JZVjF3c0VUUm0weDlDcEZiOWsifQ.eyJ1cm46dmF0b21pbmM6Z3Vlc3QiOmZhbHNlLCJ1cm46dmF0b21pbmM6cmVnaW9uIjoidXMtZWFzdDQuZ2NwIiwianRpIjoid2JsTXU0aWxJbXdQS1pjY0NIVng4Iiwic3ViIjoiMGUzN3Y5bCIsImlhdCI6MTcxNTgxNjAzMywiZXhwIjoxNzE1ODE5NjMzLCJzY29wZSI6Im9wZW5pZCBwcm9maWxlIGVtYWlsIG9mZmxpbmVfYWNjZXNzIiwiaXNzIjoiaHR0cHM6Ly9pZC52YXRvbS5jb20iLCJhdWQiOiI5NEpIa2RqOGpGODNqZkZGMkxJOFE0In0.Uux574CZdom1H58LNed8cjblhHBrWnKZgC3CpnJwE07utDpeu9grHVcWc26OUFlqKvD92Dt8dPJq0gCekUXOzCdp0r0x87jerAtl1YXnHehFYicMxwI-bgpkcSFU6Lv6OQ6H6qq8R46Pjqgx86MNqv_gqC9XRTU_mJswULsf4YhzOWRqugZqQpXZ4OZ8bDTU4dbALmL0Bgw754IDItBKKMGgyMMkAfxnk4-G2wp1qTjXoEiPkaK-rXO_rtxq3LaSVfNIH9pAq8din4SWrI5IATJExB9cOVRSfhR35V_a76UUsiMlGEPOg0rrXcDn6yWoQMooMHbADtz6WXT9bwC12A";
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
