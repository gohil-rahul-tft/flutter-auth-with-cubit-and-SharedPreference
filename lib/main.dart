import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_with_bloc/bloc/dashboard/dashboard_cubit.dart';
import 'package:login_with_bloc/bloc/login/login_cubit.dart';
import 'package:login_with_bloc/bloc/login/repo/login_repo.dart';
import 'package:login_with_bloc/screen/login_screen.dart';

import 'router/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext buildContext) {
    /*return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(AuthRepositoryImpl()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Login Sample',
        initialRoute: RouteManager.loginScreen,
        onGenerateRoute: RouteManager.generateRoute,
      ),
    );*/

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(AuthRepositoryImpl()),
        ),
        BlocProvider(
          create: (context) => DashboardCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Login Sample',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LogoutSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logout successful!')),
              );

              Navigator.of(context).pushNamedAndRemoveUntil(
                  RouteManager.loginScreen, (Route<dynamic> route) => false);
            }
          },
          // todo replace with splash screen! :)
          child: const LoginScreen(),
        ),
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
        onGenerateRoute: RouteManager.generateRoute,
      ),
    );
  }
}
