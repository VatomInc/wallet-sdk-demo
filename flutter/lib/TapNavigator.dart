import 'package:flutter/material.dart';
import 'package:vatom_wallet/Vatom/Vatom.dart';
import 'package:vatom_wallet/screens/Coupons.dart';
import 'package:vatom_wallet/screens/Home.dart';
import 'package:vatom_wallet/screens/Wallet.dart';

class TapNavigator extends StatefulWidget {
  const TapNavigator({Key? key}) : super(key: key);

  @override
  _TapNavigatorState createState() => _TapNavigatorState();
}

class _TapNavigatorState extends State<TapNavigator> {
  int _selectedIndex = 0;

  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();

    getSingletonwalletInstance();

    _widgetOptions = <Widget>[
      ThirdScreen(),
      HomePage(),
      Wallet(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tap Navigator'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Coupons',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label: 'Wallet',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}
