import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:login_with_bloc/bloc/login/login_cubit.dart';
import 'package:login_with_bloc/router/app_router.dart';
import 'package:login_with_bloc/screen/components/custom_button.dart';
import 'package:login_with_bloc/screen/components/custom_textfield.dart';
import 'package:login_with_bloc/screen/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // isLogin();
  }

  void isLogin() async {
    final preferences = await SharedPreferences.getInstance();
    bool isLogin = preferences.getBool("is_login") ?? false;

    if (isLogin) {
      // Navigator.of(context).pushReplacementNamed(RouteManager.dashboardScreen);
      /* Navigator.of(context).pushNamedAndRemoveUntil(
          RouteManager.dashboardScreen, (Route<dynamic> route) => false);*/

      // Navigator.of(context).pop(RouteManager.loginScreen);
      // Navigator.of(context).pushReplacementNamed(RouteManager.dashboardScreen);
      context.goNamed(RouteManager.dashboardScreen);
    }
  }

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Login Screen",
                    style: theme.textTheme.headline5
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: emailController,
                    hint: "Email",
                    labelText: "Enter Email",
                    validator: [
                      RequiredValidator(errorText: "Field is required"),
                      EmailValidator(errorText: "Please enter valid email"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: passwordController,
                    hint: "Password",
                    labelText: "Enter Password",
                    validator: [
                      RequiredValidator(errorText: "Field is required"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  BlocConsumer<LoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state is LoginError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message.toString())));
                      }
                      if (state is LoginSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                "${state.data.name} with ${state.data.token}"),
                          ),
                        );

                        // Navigator.of(context).pushReplacementNamed(RouteManager.dashboardScreen);
                        /*Navigator.of(context).pushNamedAndRemoveUntil(
                            RouteManager.dashboardScreen, (Route<dynamic> route) => false);*/

                        // Navigator.of(context).pop(RouteManager.loginScreen);
                        // Navigator.of(context).pushReplacementNamed(RouteManager.dashboardScreen);
                        context.goNamed(RouteManager.dashboardScreen);
                      }
                    },
                    builder: (context, state) {
                      if (state is LoginLoading) {
                        return showLoader();
                      }

                      return CustomButton(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        color: Colors.blue,
                        text: 'Login',
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            FocusManager.instance.primaryFocus!.unfocus();

                            final data = {
                              "email": emailController.text.trim(),
                              "password": passwordController.text.trim(),
                            };

                            context.read<LoginCubit>().doLogin(data);
                          }
                        },
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Do not have account?'),
                      TextButton(
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          /*Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ),
                          );*/

                          context.pushNamed(RouteManager.registerScreen);
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget errorMessage(String message) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.red),
      ),
    );
  }

  Widget showLoader() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
