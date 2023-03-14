import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_with_bloc/bloc/dashboard/dashboard_service.dart';
import 'package:login_with_bloc/data/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final _service = DashboardService();

  DashboardCubit() : super(DashboardInitial()) {
    fetchUsers();
  }

  fetchUsers() async {
    emit(DashboardLoading());
    try {
      var result = await _service.fetchUsers();
      emit(DashboardSuccess(data: result));
    } catch (e) {
      emit(DashboardError(message: "$e"));
    }
  }

  doLogout() async {
    // try {
    //   var result = await _authRepository.doLogout(/*headers*/);
    //   emit(LoginSuccess(data: result));
    // } catch (e) {
    //   emit(LoginError(message: "$e"));
    // }

    final pref = await SharedPreferences.getInstance();
    pref.clear();

    emit(const LogoutSuccess());
  }

}
