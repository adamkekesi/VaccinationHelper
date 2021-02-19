import 'package:flutter/material.dart';
import 'package:vaccination_helper/core/auth/auth_persist.dart';
import 'package:vaccination_helper/core/redux/app_state.dart';
import 'package:vaccination_helper/core/redux/store.dart';
import 'package:vaccination_helper/core/settings/settings_persist.dart';
import 'package:vaccination_helper/helpers/rest/rest_client.dart';
import 'package:async_redux/async_redux.dart';
import 'package:vaccination_helper/pages/home_page/home.dart';
import 'package:vaccination_helper/pages/loading_page/loading.dart';
import 'package:vaccination_helper/pages/login_or_register/login_or_register.dart';


void main() async {
  runApp(AppContainer());
}

class AppContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      child: VaccinationApp(),
      store: store,
    );
  }
}

class VaccinationApp extends StatelessWidget {
  const VaccinationApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Vaccination Helper', home: Home());
  }
}
