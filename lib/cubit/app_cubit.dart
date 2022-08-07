import 'package:bloc/bloc.dart';
import 'package:flutter_hello_world/cubit/app_cubit_state.dart';
import 'package:flutter_hello_world/services/data_services.dart';

class AppCubit extends Cubit<CubitState> {
  final DataServices _services;

  AppCubit({required DataServices services})
      : this._services = services,
        super(InitialState()) {
    emit(WelcomeState());
  }

  void getTrips() async {
    try {
      emit(LoadingState());
      final trips = await _services.getTrips();
      emit(LoadedState(trips));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
