import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login_with_bloc/router/app_router.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({Key? key}) : super(key: key);

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int position = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.blueGrey,
      currentIndex: position,
      onTap: (value) => _onTap(value),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
      unselectedLabelStyle: const TextStyle(
        color: Colors.grey,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      items: const [
        BottomNavigationBarItem(
            activeIcon: Icon(Icons.home),
            icon: Icon(Icons.home_work),
            label: 'Home'),
        BottomNavigationBarItem(
            activeIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_applications),
            label: 'Setting'),
      ],
    );
  }

  void _onTap(int index) {
    setState(() {
      position = index;
    });

    print(index.toString());

    switch (index) {
      case 0:
        return context.go(RouteManager.dashboardScreen);

      case 1:
        return context.goNamed(RouteManager.settingScreen);

      default:
        return context.go(RouteManager.dashboardScreen);
    }
  }
}
