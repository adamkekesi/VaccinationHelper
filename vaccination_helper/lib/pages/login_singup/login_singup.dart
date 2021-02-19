import 'package:flutter/material.dart';
import 'package:vaccination_helper/core/translation/translator.dart';
import 'package:vaccination_helper/pages/loading/loading.dart';
import 'package:vaccination_helper/pages/account_type/account_type.dart';

class Login extends StatelessWidget {
  Login({this.translator});
  Translator translator;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Bejelentkezés',
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
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new AccountType()));
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
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 90),
              onPressed: () {},
              color: Colors.cyan[500],
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
