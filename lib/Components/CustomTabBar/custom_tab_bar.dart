import 'package:flutter/material.dart';
import 'package:nodelabscase/Core/Theme/app_colors.dart';
import 'package:nodelabscase/Core/Theme/app_icons.dart';

class CustomTabBar extends StatefulWidget {
  final int initialIndex;
  final ValueChanged<int> onTabChanged;

  const CustomTabBar({
    super.key,
    this.initialIndex = 0,
    required this.onTabChanged,
  });

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  late int selectedIndex;

  final List<Map<String, dynamic>> _tabs = const [
    {
      "label": "Home Page",
      "activeIcon": AppIcons.homeFill,
      "inactiveIcon": AppIcons.home,
    },
    {
      "label": "Profile",
      "activeIcon": AppIcons.profileFill,
      "inactiveIcon": AppIcons.profile,
    },
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  void onTabTap(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onTabChanged(index);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(_tabs.length, (index) {
        final isActive = index == selectedIndex;
        final tab = _tabs[index];

        return SizedBox(
          width: 200,
          child: GestureDetector(
            onTap: () => onTabTap(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                gradient: isActive ? AppColors.activeNav : null,
                color: isActive ? null : Colors.transparent,
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(42),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppSvg(
                    isActive ? tab["activeIcon"] : tab["inactiveIcon"],
                    size: 20,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    tab["label"],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
