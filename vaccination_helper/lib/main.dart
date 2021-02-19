import 'package:flutter/material.dart';
import 'package:vaccination_helper/core/auth/auth_persist.dart';
import 'package:vaccination_helper/core/redux/app_state.dart';
import 'package:vaccination_helper/core/redux/store.dart';
import 'package:vaccination_helper/core/settings/settings_persist.dart';
import 'package:vaccination_helper/helpers/rest/rest_client.dart';
import 'package:async_redux/async_redux.dart';
import 'package:vaccination_helper/pages/home/home.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      child: MaterialApp(title: 'Demo App', home: Home()),
      store: store,
    );
  }
}
