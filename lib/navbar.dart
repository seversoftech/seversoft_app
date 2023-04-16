import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seversoftapp/screens/electricity.dart';
import 'package:seversoftapp/screens/hompage.dart';
import 'screens/airtime.dart';
import 'screens/cable.dart';
import 'screens/data.dart';

class NavBarHome extends StatefulWidget {
  const NavBarHome({Key? key}) : super(key: key);

  @override
  State<NavBarHome> createState() => _NavBarHomeState();
}

class _NavBarHomeState extends State<NavBarHome> {
  final _pageController = PageController(initialPage: 2);

  int maxCount = 5;

  // widget list
  final List<Widget> bottomBarPages = [
    Data(),
    Airtime(),
    Hompage(),
    Cable(),
    Electricity(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              showBlurBottomBar: false,
              pageController: _pageController,
              color: Colors.white,
              showLabel: true,
              notchColor: Color(0xFF08062C),
              bottomBarItems: [
                const BottomBarItem(
                  inActiveItem: Icon(
                    Icons.podcasts,
                    color: Color(0xFF08062C),
                  ),
                  activeItem: Icon(
                    Icons.podcasts_outlined,
                    color: Colors.greenAccent,
                  ),
                  itemLabel: 'Data',
                ),
                const BottomBarItem(
                  inActiveItem: Icon(
                    Icons.sim_card,
                    color: Color(0xFF08062C),
                  ),
                  activeItem: Icon(
                    Icons.sim_card,
                    color: Colors.blueAccent,
                  ),
                  itemLabel: 'Airtime',
                ),
                BottomBarItem(
                  inActiveItem: SvgPicture.asset(
                    'assets/icons/home.svg',
                    color: Color(0xFF08062C),
                  ),
                  activeItem: SvgPicture.asset(
                    'assets/icons/home.svg',
                    color: Colors.white,
                  ),
                  itemLabel: 'Home',
                ),
                const BottomBarItem(
                  inActiveItem: Icon(
                    Icons.tv,
                    color: Color(0xFF08062C),
                  ),
                  activeItem: Icon(
                    Icons.tv,
                    color: Colors.pink,
                  ),
                  itemLabel: 'Cable Tv',
                ),
                const BottomBarItem(
                  inActiveItem: Icon(
                    Icons.electric_bolt,
                    color: Color(0xFF08062C),
                  ),
                  activeItem: Icon(
                    Icons.electric_bolt,
                    color: Colors.yellow,
                  ),
                  itemLabel: 'Electricity',
                ),
              ],
              onTap: (index) {
                /// control your animation using page controller
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                );
              },
            )
          : null,
    );
  }
}
