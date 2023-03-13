import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:login_with_bloc/bloc/login/login_cubit.dart';
import 'package:login_with_bloc/screen/dashboard_screen.dart';
import 'package:login_with_bloc/screen/home_screen.dart';
import 'package:login_with_bloc/screen/login_screen.dart';
import 'package:login_with_bloc/screen/register_screen.dart';
import 'package:login_with_bloc/screen/setting_screen.dart';

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: 'root');

final GlobalKey<NavigatorState> _shellNavigator =
    GlobalKey(debugLabel: 'shell');

class RouteManager {
  static const String splashScreen = '/splash';

  // static const String homeScreen = '/loginScreen';
  static const String loginScreen = '/';
  static const String registerScreen = '/registerScreen';
  static const String dashboardScreen = '/dashboardScreen';

  /// The route configuration.
  static final GoRouter router = GoRouter(
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
      GoRoute(
        name: dashboardScreen,
        path: dashboardScreen,
        builder: (context, state) {
          return const DashboardScreen();
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
                ));
              },
            ),
            GoRoute(
              path: '/setting',
              name: "setting",
              pageBuilder: (context, state) {
                return NoTransitionPage(
                    child: SettingScreen(
                  key: state.pageKey,
                ));
              },
            )
          ])
    ],
    redirect: (context, state) async {
      final isLogin = await context.read<LoginCubit>().isLogin();
      final isLoginRoute = state.location.startsWith(RouteManager.loginScreen);

      if (isLogin && isLoginRoute) {
        return RouteManager.dashboardScreen;
      } else if (!isLogin && isLoginRoute) {
        return RouteManager.loginScreen;
      }

      return null;
    },
  );
}
