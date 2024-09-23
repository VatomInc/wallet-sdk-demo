import 'package:flutter/material.dart';
import 'package:vatom_wallet/Home.dart';
import 'package:vatom_wallet/Wallet.dart';

class TapNavigator extends StatefulWidget {
  final String at;
  final String? baseUrl;
  final String? businessId;
  final String? campaingId;

  const TapNavigator(
      {Key? key,
      required this.at,
      this.baseUrl,
      this.businessId,
      this.campaingId})
      : super(key: key);

  @override
  _TapNavigatorState createState() => _TapNavigatorState();
}

class _TapNavigatorState extends State<TapNavigator> {
  int _selectedIndex = 0;

  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      MyHomePage(
        at: widget.at,
        baseUrl: widget.baseUrl,
        businessId: widget.businessId,
        campaingId: widget.campaingId,
      ),
      Wallet(
          at: widget.at,
          baseUrl: widget.baseUrl,
          businessId: widget.businessId),
      ThirdScreen(),
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
            icon: Icon(Icons.person),
            label: 'Tickets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'School Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
