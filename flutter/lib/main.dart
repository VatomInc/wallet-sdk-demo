import 'package:flutter/material.dart';
import 'package:vatom_wallet/Nav.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vatom Wallet',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: TapNavigator(
        at: "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Imw0Mjd4WnJxNjJlR0xhS0hhc0d0bkkyZ1JZVjF3c0VUUm0weDlDcEZiOWsifQ.eyJ1cm46dmF0b21pbmM6bG9nZ2VkLWluLXZpYSI6Im1hZ2ljLWNvZGUiLCJ1cm46dmF0b21pbmM6Z3Vlc3QiOmZhbHNlLCJ1cm46dmF0b21pbmM6cmVnaW9uIjoidXMtZWFzdDQuZ2NwIiwianRpIjoiMWxjVVp4T1Rwcm44NWFORTdVYkhlIiwic3ViIjoiMGUzN3Y5bCIsImlhdCI6MTcyNjg4MzIxMCwiZXhwIjoxNzI2ODg2ODEwLCJzY29wZSI6Im9wZW5pZCBwcm9maWxlIGVtYWlsIG9mZmxpbmVfYWNjZXNzIiwiaXNzIjoiaHR0cHM6Ly9pZC52YXRvbS5jb20iLCJhdWQiOiI5NEpIa2RqOGpGODNqZkZGMkxJOFE0In0.jClUk8mQR_x1MGxm_8SPwtH8d_QNMNgEEPhiTYmr0QwUrL4KErBz6BsxlRxaewYz2h-1dTOo8R_jNbxsZQzuNSbXYp_vHK7d1h5svd-a81VTkDB-PeBk9vvu57Xc-YchHZfI9SfqNlj2nrSFMbZLowJv4TwM_ICFo7VPa2Vf7NgPmxpEJYUfsWx7ea5VP70f-YPyzjMPTkeZh6a60toCpyCoBINqcPE6Dxw3FbiZ7EPEduWZCruCSP1IWf8bL-w9PT1e9xmNQgNrmEvgtCrCFAO8ifX32bs_MuXqJsMpo8J4pJBm_sHzBOJSga6lYbAtaUNjtFNlslq41KkoCSe4CQ",
        businessId: "dALCDZAzCA",
        campaingId: "70nIsRCpgp",
      ),
    );
  }
}
