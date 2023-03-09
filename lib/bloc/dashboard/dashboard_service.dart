import 'dart:convert';

import 'package:http/http.dart';
import 'package:login_with_bloc/data/login_response.dart';
import 'package:login_with_bloc/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardService {
  Future<List<LoginResponse>> fetchUsers() async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString("token");

    final response = await get(
      Uri.parse('${Constants.BASE_URL}/${Constants.USER}'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final res = jsonDecode(response.body);
      List<LoginResponse> users =
          (res as List).map((json) => LoginResponse.fromJson(json)).toList();

      return users;
    } else if (response.statusCode == 401) {
      throw Exception('Authentication failed!');
    } else {
      throw Exception('Something went wrong!');
    }
  }
}
