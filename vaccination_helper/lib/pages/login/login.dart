import 'package:flutter/material.dart';
import 'package:vaccination_helper/core/auth/dtos/login_dto.dart';
import 'package:vaccination_helper/core/translation/translator.dart';
import 'package:vaccination_helper/helpers/exceptions/base_exception.dart';
import 'package:vaccination_helper/helpers/types.dart';
import 'package:vaccination_helper/pages/loading/loading.dart';
import 'package:vaccination_helper/pages/account_type/account_type.dart';
import 'package:vaccination_helper/pages/user_home/user_home.dart';

class Login extends StatefulWidget {
  final LoginDto payload;

  final BuildContextFunction onSent;

  Login({this.payload, this.onSent});

  @override
  _LoginState createState() => _LoginState(payload: payload, onSent: onSent);
}

class _LoginState extends State<Login> {
  final LoginDto payload;

  final BuildContextFunction onSent;

  _LoginState({this.payload, this.onSent});

  bool secureText = true;

  final GlobalKey<FormState> _formKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Email cannot be empty';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
              onSaved: (newValue) {
                payload.email = newValue;
              },
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
                  return 'Password cannot be empty';
                }
                return null;
              },
              onSaved: (newValue) {
                payload.password = newValue;
              },
              decoration: InputDecoration(
                  labelText: 'Passworld',
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
              _formKey.currentState.save();
              onSent(context);
            },
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
        ],
      ),
    );
  }
}
