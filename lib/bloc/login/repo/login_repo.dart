import 'package:login_with_bloc/bloc/login/login_service.dart';
import 'package:login_with_bloc/data/login_response.dart';


class AuthRepositoryImpl implements AuthRepository {
  var service = LoginService();

  @override
  Future<LoginResponse> doLogin(Map<String, dynamic> data) => service.doLogin(data);

  @override
  Future<LoginResponse> doRegister(Map<String, dynamic> data) => service.doRegister(data);
}

abstract class AuthRepository {
  Future<LoginResponse> doLogin(Map<String, dynamic> data);
  Future<LoginResponse> doRegister(Map<String, dynamic> data);
}
