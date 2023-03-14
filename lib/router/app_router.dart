import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:login_with_bloc/bloc/login/login_cubit.dart';
import 'package:login_with_bloc/screen/dashboard_screen.dart';
import 'package:login_with_bloc/screen/home_screen.dart';
import 'package:login_with_bloc/screen/login_screen.dart';
import 'package:login_with_bloc/screen/register_screen.dart';
import 'package:login_with_bloc/screen/setting_screen.dart';
import 'package:login_with_bloc/screen/widget/app_scaffold.dart';

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: 'root');

final GlobalKey<NavigatorState> _shellNavigator =
    GlobalKey(debugLabel: 'shell');

class RouteManager {
  static const String splashScreen = '/splash';

  // static const String homeScreen = '/loginScreen';
  static const String loginScreen = '/loginScreen';
  static const String registerScreen = '/registerScreen';
  static const String dashboardScreen = '/';
  static const String settingScreen = '/settingScreen';

  /// The route configuration.
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigator,
    routes: [
      GoRoute(
        name: loginScreen,
        path: loginScreen,
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        name: registerScreen,
        path: registerScreen,
        builder: (context, state) {
          return const RegisterScreen();
        },
      ),
      ShellRoute(
        navigatorKey: _shellNavigator,
        builder: (context, state, child) =>
            HomeScreen(key: state.pageKey, child: child),
        routes: [
          GoRoute(
            path: dashboardScreen,
            name: dashboardScreen,
            pageBuilder: (context, state) {
              return NoTransitionPage(
                child: DashboardScreen(
                  key: state.pageKey,
                ),
              );
            },
          ),
          GoRoute(
            path: settingScreen,
            name: settingScreen,
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: Center(
                  child: Text('Settings'),
                ),
              );
            },
          )
        ],
      )
    ],
    redirect: (context, state) async {
      final isLogin = await context.read<LoginCubit>().isLogin();
      final isDashboardRoute =
          state.location.startsWith(RouteManager.dashboardScreen);

      if (!isLogin && isDashboardRoute) {
        return RouteManager.loginScreen;
      }

      return null;
    },
  );
}
