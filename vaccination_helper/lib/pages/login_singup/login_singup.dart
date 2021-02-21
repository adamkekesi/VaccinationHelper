import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vaccination_helper/core/translation/translator.dart';
import 'package:vaccination_helper/helpers/types.dart';
import 'package:vaccination_helper/pages/account_type/account_type_connector.dart';
import 'package:vaccination_helper/pages/loading/loading.dart';
import 'package:vaccination_helper/pages/account_type/account_type.dart';
import 'package:vaccination_helper/pages/login/login.dart';
import 'package:vaccination_helper/pages/user_home/user_home.dart';

class LandingPage extends StatelessWidget {
  final BuildContextFunction jumpToLoginPage;

  LandingPage({this.translator, this.jumpToLoginPage});
  Translator translator;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double contWidth = size.width * 0.90;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Vaccination Helper',
          style: TextStyle(fontFamily: 'Comfortaa'),
        ),
        centerTitle: true,
        elevation: 10,
        backgroundColor: Colors.cyan,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 90),
                onPressed: () => jumpToLoginPage(context),
                color: Colors.cyan[500],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Text(
                  "Log In",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Comfortaa',
                    fontSize: 25,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Or",
                style: TextStyle(fontFamily: 'Comfortaa', fontSize: 20),
              ),
              SizedBox(
                height: 40,
              ),
              RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 80),
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new AccountTypeConnector()));
                },
                color: Colors.cyan,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Text(
                  "Sing Up",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Comfortaa',
                    fontSize: 25,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
