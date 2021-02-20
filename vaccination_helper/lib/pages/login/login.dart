import 'package:flutter/material.dart';
import 'package:vaccination_helper/core/translation/translator.dart';
import 'package:vaccination_helper/pages/loading/loading.dart';
import 'package:vaccination_helper/pages/account_type/account_type.dart';
import 'package:vaccination_helper/pages/user_home/user_home.dart';
import 'package:vaccination_helper/pages/user_home/user.dart';

class Login extends StatefulWidget {
  Login({this.translator});
  Translator translator;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool secureText = true;

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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Username cannot be empty';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Email cím',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Username cannot be empty';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: 'Jelszó',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                          secureText ? Icons.remove_red_eye : Icons.security),
                      onPressed: () {
                        setState(() {
                          secureText = !secureText;
                        });
                      },
                    )),
                obscureText: secureText,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 90),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new Home()));
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
          ],
        ),
      ),
    );
  }
}
