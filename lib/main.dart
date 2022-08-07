import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hello_world/cubit/app_cubit.dart';
import 'package:flutter_hello_world/cubit/app_cubit_logic.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hello_world/services/data_services.dart';

void main() => runApp(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<DataServices>(
            create: (context) => DataServices(),
          ),
        ],
        child: BlocProvider<AppCubit>(
          create: (context) => AppCubit(services: context.read<DataServices>()),
          child: MyApp(),
        ),
      ),
    );

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AppCubitLogicWidget(),
    );
  }
}
