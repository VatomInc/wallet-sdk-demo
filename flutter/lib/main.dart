import 'package:flutter/material.dart';
import 'package:vatom_wallet/TapNavigator.dart';

void main() {
  runApp(MyApp());
}

String getBusinessId() {
  return "dALCDZAzCA";
}

String getcampaignId() {
  return "h52qnYLsFe";
}

String getAt() {
  return "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Imw0Mjd4WnJxNjJlR0xhS0hhc0d0bkkyZ1JZVjF3c0VUUm0weDlDcEZiOWsifQ.eyJ1cm46dmF0b21pbmM6Z3Vlc3QiOmZhbHNlLCJ1cm46dmF0b21pbmM6cmVnaW9uIjoidXMtZWFzdDQuZ2NwIiwianRpIjoiVWRkWHpJZllnTnl0N2xMWGRtRVJJIiwic3ViIjoiMGUzN3Y5bCIsImlhdCI6MTcyNzczNDMxMiwiZXhwIjoxNzI3NzM3OTEyLCJzY29wZSI6Im9wZW5pZCBwcm9maWxlIGVtYWlsIG9mZmxpbmVfYWNjZXNzIiwiaXNzIjoiaHR0cHM6Ly9pZC52YXRvbS5jb20iLCJhdWQiOiI5NEpIa2RqOGpGODNqZkZGMkxJOFE0In0.QXY_QiCsCghVAwn3lByRq5J1SHdIwnoQP5FY5oyunxM-FESB_mzy_XGrD1hOmMcXiksBBbqilUvUlbC-cO3rAKNQSIqoLM3LekyoYDcag1ya3ZckndGZ7mQAQUGQFiOcDycqh9i2jmfjRfLefcDzq4FZzWcyJTAQ_hgIw2imsgJ35JX_TtJTFuU4YU7utW0l0uE8NVKattPgWyR_RbWf-TkiXqfubc6OFW4XYcoBaA62dp7y22Qc452SWkgRO-ayp2p8TB19qhDcT96_yq37jamFIkEY02pPUky8UVkLFPcambFYcA9h05fXy0ug554QuvLwa4ptQMsTr2ESsGP73Q";
}

String getBaseUrl() {
  return "https://wallet.vatom.com";
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vatom Wallet',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: TapNavigator(),
    );
  }
}
