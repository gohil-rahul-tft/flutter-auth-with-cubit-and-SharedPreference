import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:login_with_bloc/bloc/login/login_cubit.dart';
import 'package:login_with_bloc/router/app_router.dart';
import 'package:login_with_bloc/screen/components/custom_button.dart';
import 'package:login_with_bloc/screen/components/custom_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
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
                  "Register Screen",
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
                        const SnackBar(
                          content: Text("Register Successfully!"),
                        ),
                      );

                      Navigator.of(context).pop();
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
                      text: 'Register',
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          FocusManager.instance.primaryFocus!.unfocus();

                          final data = {
                            "email": emailController.text.trim(),
                            "password": passwordController.text.trim(),
                          };

                          context.read<LoginCubit>().doRegister(data);
                        }
                      },
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have account?'),
                    TextButton(
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        context.goNamed(RouteManager.loginScreen);
                      },
                    )
                  ],
                ),
              ],
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
