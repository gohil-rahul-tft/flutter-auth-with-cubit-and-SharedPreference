import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:login_with_bloc/bloc/dashboard/dashboard_cubit.dart';
import 'package:login_with_bloc/bloc/login/login_cubit.dart';
import 'package:login_with_bloc/screen/components/custom_button.dart';
import 'package:login_with_bloc/screen/components/custom_textfield.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () {
              // Perform logout action here
              print("logout clicked");
              context.read<LoginCubit>().doLogout();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: BlocConsumer<DashboardCubit, DashboardState>(
        listener: (context, state) {
          if (state is DashboardError) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message.toString())));
          }
        },
        builder: (context, state) {
          if (state is DashboardLoading) {
            return showLoader();
          } else if (state is DashboardSuccess) {
            final data = state.data;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return ListTile(
                  title: Text(item.name ?? ""),
                  subtitle: Text(item.email ?? ""),
                  leading: const Icon(Icons.person),
                  onTap: () {},
                );
              },
            );
          }

          return Container();
        },
      ),
    );
  }

  Widget showLoader() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}