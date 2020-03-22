import 'package:azap_app/design_system/flavor/flavor_banner.dart';
import 'package:azap_app/design_system/theme.dart';
import 'package:azap_app/doctor/navigation/navigation.dart';
import 'package:azap_app/doctor/presentation/home/home_page.dart';
import 'package:azap_app/doctor/presentation/onboarding/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stetho/flutter_stetho.dart';

import 'domain/session/session_bloc.dart';
import 'flavors.dart';

// To launch: flutter run -t lib/doctor/main_doctor.dart

void main() {
  Stetho.initialize();
  FlavorConfig(
      flavor: Flavor.PRODUCTION,
      color: Colors.deepPurpleAccent,
      values: FlavorValues(baseUrl: "https://mock"));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _sessionBloc = SessionBloc();

    return BlocProviderTree(
        blocProviders: [
          BlocProvider<SessionBloc>(bloc: _sessionBloc),
        ],
//      bloc: prefsBloc,
        child: MaterialApp(
            title: 'Flutter Login',
            theme: ThemeData(
                primaryColor: mainColor,
                accentColor: accentColor),
            routes: {
              Navigation.home: (context) =>
                  FlavorBanner(child: HomePage(onInit: () => print("home"))),
              Navigation.login: (context) =>
                  FlavorBanner(child: LoginPage(onInit: () => print("Login")))
            }));
  }
}
