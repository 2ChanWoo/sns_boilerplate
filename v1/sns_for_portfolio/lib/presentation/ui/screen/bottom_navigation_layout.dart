import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/util/dev_log.dart';

class BottomNavigationLayout extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const BottomNavigationLayout({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          Log.d("[BottomNavigationLayout] onTapped");
          navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex);
        },
        items: const [
          BottomNavigationBarItem(
            label: '',
            // activeIcon: hasBadge == true ? badgeIcon : icon,
            icon: Icon(Icons.sunny),
          ),
          BottomNavigationBarItem(
            label: '',
            // activeIcon: hasBadge == true ? badgeIcon : icon,
            icon: Icon(Icons.rocket_launch_outlined),
            // icon: Icon(Icons.family_star),
          ),
          BottomNavigationBarItem(
            label: '',
            // activeIcon: hasBadge == true ? badgeIcon : icon,
            icon: Icon(Icons.add_box_outlined),
          ),
          BottomNavigationBarItem(
            label: '',
            // activeIcon: hasBadge == true ? badgeIcon : icon,
            icon: Icon(Icons.menu_book),
          ),
          BottomNavigationBarItem(
            label: '',
            // activeIcon: hasBadge == true ? badgeIcon : icon,
            icon: Icon(Icons.settings_outlined),
          ),
        ],
      ),
    );
  }
}
