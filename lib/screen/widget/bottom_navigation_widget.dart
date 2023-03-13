
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({Key? key}) : super(key: key);

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  var position = 0;

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
            label: 'Home'
        ),
        BottomNavigationBarItem(
            activeIcon: Icon(Icons.shopify),
            icon: Icon(Icons.shopping_bag),
            label: 'Cart'
        ),
        BottomNavigationBarItem(
            activeIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_applications),
            label: 'Setting'
        ),
      ],
    );
  }

  void _onTap(int index) {
    position = index;

    switch (index) {
      case 0:
        context.go('/');
        break;


      case 1:
        context.go('/setting');
        break;

      default:
    }
  }
}