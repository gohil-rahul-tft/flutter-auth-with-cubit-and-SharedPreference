import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_with_bloc/bloc/login/login_cubit.dart';
import 'package:login_with_bloc/bloc/login/repo/login_repo.dart';

import 'router/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Login Sample',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
        onGenerateRoute: RouteManager.generateRoute,
      ),
    );
  }
}
