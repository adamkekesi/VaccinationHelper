import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vaccination_helper/core/translation/translator.dart';
import 'package:vaccination_helper/pages/loading/loading.dart';
import 'package:vaccination_helper/pages/account_type/account_type.dart';
import 'package:vaccination_helper/pages/login/login.dart';
import 'package:vaccination_helper/pages/test.dart';

class LandingPage extends StatelessWidget {
  LandingPage({this.translator});
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 90),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new Login()));
              },
              color: Colors.cyan[500],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Text(
                "Bejelentkezés",
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
              "Vagy",
              style: TextStyle(fontFamily: 'Comfortaa', fontSize: 20),
            ),
            SizedBox(
              height: 40,
            ),
            RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new AccountType()));
              },
              color: Colors.cyan,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Text(
                "Felhasználó létrehozása",
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
    );
  }
}
