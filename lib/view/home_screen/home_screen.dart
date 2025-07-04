import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websoket/view/home_screen/price_track_controller.dart';
import 'package:websoket/view/home_screen/price_view_page.dart';
import 'package:websoket/view/home_screen/channel_management_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PriceTrackerController controller = Get.put(PriceTrackerController());
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    PriceViewPage(),
    ChannelManagementPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Price Tracker')),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.price_check),
            label: 'Price',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_ethernet),
            label: 'Channel',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
