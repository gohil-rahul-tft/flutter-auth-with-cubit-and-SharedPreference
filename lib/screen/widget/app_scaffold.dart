import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login_with_bloc/router/app_router.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Billion Dollar App')),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _calculateSelectedIndex(context),
        onTap: (value) => onTap(value),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home',),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box), label: 'Account'),
        ],
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final GoRouter route = GoRouter.of(context);
    final String location = route.location;
    if (location.startsWith(RouteManager.dashboardScreen)) {
      return 0;
    }
    if (location.startsWith('/search')) {
      return 1;
    }
    if (location.startsWith('/account')) {
      return 2;
    }
    return 0;
  }

  void onTap(int value) {
    final GoRouter route = GoRouter.of(context);

    switch (value) {
      case 0:
        return route.go(RouteManager.dashboardScreen);
      case 1:
        return route.go('/search');
      case 2:
        return route.go('/account');
      default:
        return route.go('/home');
    }
  }
}
