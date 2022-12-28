import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_with_bloc/data/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'repo/login_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(LoginInitial());

  doLogin(Map<String, dynamic> data) async {
    emit(LoginLoading());
    try {
      var result = await _authRepository.doLogin(data);

      final pref = await SharedPreferences.getInstance();
      pref.setString("token", result.token.toString());
      pref.setInt("id", result.id ?? 0);
      pref.setBool("is_login", true);

      emit(LoginSuccess(data: result));
    } catch (e) {
      emit(LoginError(message: "$e"));
    }
  }

  doRegister(Map<String, dynamic> data) async {
    emit(LoginLoading());
    try {
      var result = await _authRepository.doRegister(data);
      emit(LoginSuccess(data: result));
    } catch (e) {
      emit(LoginError(message: "$e"));
    }
  }
}
