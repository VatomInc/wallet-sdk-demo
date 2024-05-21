import 'package:flutter/material.dart';
import 'package:vatom_flutter/Ar.dart';
import 'package:vatom_flutter/Home.dart';
import 'package:vatom_flutter/VatomController.dart';
import 'package:vatom_flutter/Wallet.dart';

class TabBarDemoWithVatomWallet extends StatelessWidget {
  const TabBarDemoWithVatomWallet({Key? key}) : super(key: key);

  final vatomToken =
      "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Imw0Mjd4WnJxNjJlR0xhS0hhc0d0bkkyZ1JZVjF3c0VUUm0weDlDcEZiOWsifQ.eyJ1cm46dmF0b21pbmM6bG9nZ2VkLWluLXZpYSI6Im1hZ2ljLWNvZGUiLCJ1cm46dmF0b21pbmM6Z3Vlc3QiOmZhbHNlLCJ1cm46dmF0b21pbmM6cmVnaW9uIjoidXMtZWFzdDQuZ2NwIiwianRpIjoic0NDTi1aeWVVWnZ3U0NwcjFReHg2Iiwic3ViIjoiMGUzN3Y5bCIsImlhdCI6MTcxNTkxMjUxMCwiZXhwIjoxNzE1OTE2MTEwLCJzY29wZSI6Im9wZW5pZCBwcm9maWxlIGVtYWlsIG9mZmxpbmVfYWNjZXNzIiwiaXNzIjoiaHR0cHM6Ly9pZC52YXRvbS5jb20iLCJhdWQiOiI5NEpIa2RqOGpGODNqZkZGMkxJOFE0In0.UJj42AJ9HZgMdweqAIspQTy7AtmYBpTeXXdzmOE5jbp67Op1qbJOkSxIQYNNlvWuxCn-HwXg1hPpcc7ZtGNAHBBvpaSH0NoiCQmix6EKOQj7AU8FdhlgIVJ4nDbYD8CVtJ3aJ-H8voq8lgeomiXdlJ6i4wKpup6ILiNDfkY6-e9DhYohAyNLwvVMYT7-3tet7Q8-eRaSOjTw-82njI2WjYorykX4xG-Dz80PYjBqcDv9hazPy1epLzPKJbWI2PwSMvzvUMsujty1bjZxVEJU5GzcH5X5PvYtBJ_GJ8aAh5riwOjxgrU4W4aJpSoYfks0nTouY_agQcKjFnVe_sxAFw";
  @override
  Widget build(BuildContext context) {
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
              vatomToken: vatomToken,
            ),
            Wallet(
              vatomToken: vatomToken,
            ),
            Ar(
              vatomToken: vatomToken,
            )
          ],
        ),
      ),
    );
  }
}
