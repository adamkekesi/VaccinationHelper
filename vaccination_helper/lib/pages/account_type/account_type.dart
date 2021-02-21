import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vaccination_helper/core/translation/translator.dart';
import 'package:vaccination_helper/helpers/types.dart';
import 'package:vaccination_helper/pages/loading/loading.dart';
import 'package:vaccination_helper/pages/user_sing_up/user_sign_up.dart';

class AccountType extends StatelessWidget {
  final BuildContextFunction jumpToPatient;

  final BuildContextFunction jumpToDoctor;

  AccountType({this.translator, this.jumpToDoctor, this.jumpToPatient});
  Translator translator;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Type of Users',
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
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 80),
              onPressed: () => jumpToPatient(context),
              color: Colors.cyan[500],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Text(
                "Patient",
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
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 90),
              onPressed: () => jumpToDoctor(context),
              color: Colors.cyan[500],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Text(
                "Doctor",
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
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              onPressed: () {},
              color: Colors.cyan[500],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Column(children: [
                Text(
                  "Administartor",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Comfortaa',
                    fontSize: 25,
                  ),
                ),
                Text(
                  "(*comming soon)",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Comfortaa',
                      fontSize: 20),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
