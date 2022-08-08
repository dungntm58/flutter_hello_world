import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hello_world/cubit/app_cubit.dart';
import 'package:flutter_hello_world/cubit/app_cubit_state.dart';
import 'package:flutter_hello_world/pages/detail_page.dart';
import 'package:flutter_hello_world/pages/main_page.dart';
import 'package:flutter_hello_world/pages/welcome_page.dart';

class AppCubitLogicWidget extends StatefulWidget {
  const AppCubitLogicWidget({Key? key}) : super(key: key);

  @override
  State<AppCubitLogicWidget> createState() => _AppCubitLogicWidgetState();
}

class _AppCubitLogicWidgetState extends State<AppCubitLogicWidget> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        body: BlocConsumer<AppCubit, CubitState>(
          listenWhen: (previous, current) => current is ErrorState,
          listener: (context, dynamic state) {
            if (state is ErrorState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          builder: (context, dynamic state) {
            if (state is WelcomeState) {
              return WelcomePage();
            } else if (state is LoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is LoadedState) {
              return MainPage();
            } else if (state is DetailState) {
              return DetailPage(trip: state.trip);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
