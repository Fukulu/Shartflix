import 'package:flutter/material.dart';
import 'package:nodelabscase/View/Profile/profile_page.dart';

import '../../Components/CustomTabBar/custom_tab_bar.dart';
import '../../Core/Theme/app_colors.dart';
import 'home_page.dart';

class TabControllerPage extends StatefulWidget {
  const TabControllerPage({super.key});

  @override
  State<TabControllerPage> createState() => _TabControllerPageState();
}

class _TabControllerPageState extends State<TabControllerPage> {

  int _selectedIndex = 0;

  void _onTabChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = const [
    HomePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [

          IndexedStack(
            index: _selectedIndex,
            children: _pages,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomTabBar(
                  initialIndex: _selectedIndex,
                  onTabChanged: _onTabChanged,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
