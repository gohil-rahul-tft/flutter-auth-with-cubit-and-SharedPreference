import 'dart:convert';

import 'package:http/http.dart';
import 'package:login_with_bloc/data/login_response.dart';
import 'package:login_with_bloc/utils/constants.dart';

class LoginService {
  Future<LoginResponse> doLogin(Map<String, dynamic> data) async {
    var response = await post(
        Uri.parse('${Constants.BASE_URL}/${Constants.LOGIN}'),
        body: data);

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      throw Exception('Invalid Email or Password');
    } else {
      throw Exception('Something went wrong!');
    }
  }

  Future<LoginResponse> doRegister(Map<String, dynamic> data) async {
    var response = await post(
        Uri.parse('${Constants.BASE_URL}/${Constants.REGISTER}'),
        body: data);

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      throw Exception('Invalid Email or Password');
    } else {
      throw Exception('Something went wrong!');
    }
  }
}
