import 'package:flutter/material.dart';

const TextStyle _textStyle = TextStyle(
  fontSize: 40,
  fontWeight: FontWeight.bold,
  letterSpacing: 2,
  fontStyle: FontStyle.italic,
);

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  List<Widget> pages = const [
    Text('Home', style: _textStyle),
    Text('Data', style: _textStyle),
    Text('Airtime', style: _textStyle),
    Text('Cable TV', style: _textStyle),
    Text('Electricity', style: _textStyle),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pages[_currentIndex],
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.white.withOpacity(0.5),
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
        child: NavigationBar(
          backgroundColor: Colors.blue,
          selectedIndex: _currentIndex,
          animationDuration: const Duration(seconds: 1),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          height: 60,
          onDestinationSelected: (int newIndex) {
            setState(() {
              _currentIndex = newIndex;
            });
          },
          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.wifi_rounded),
              icon: Icon(Icons.wifi_outlined),
              label: 'Data',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.phone_iphone),
              icon: Icon(Icons.phone_iphone_outlined),
              label: 'Airtime',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.tv),
              icon: Icon(Icons.tv_outlined),
              label: 'Cable',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.offline_bolt),
              icon: Icon(Icons.offline_bolt_outlined),
              label: 'Electricity',
            )
          ],
        ),
      ),
    );
  }
}
