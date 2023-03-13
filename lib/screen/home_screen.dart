import 'package:flutter/material.dart';

import 'widget/bottom_navigation_widget.dart';

class HomeScreen extends StatefulWidget {
  final Widget child;
  const HomeScreen({required this.child, Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
