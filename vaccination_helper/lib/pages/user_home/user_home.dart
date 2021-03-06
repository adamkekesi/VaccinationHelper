import 'package:flutter/material.dart';
import 'package:vaccination_helper/core/translation/translator.dart';
import 'package:vaccination_helper/pages/doc/doc.dart';
import 'package:vaccination_helper/pages/doctor_search/doctor_search.dart';
import 'package:vaccination_helper/pages/user_home/main.drawer.dart';
import 'package:vaccination_helper/pages/user_home/main_drawer_connector.dart';

class UserHome extends StatefulWidget {
  UserHome();

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<UserHome> {
  bool secureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(fontFamily: 'Comfortaa'),
        ),
        centerTitle: true,
        elevation: 10,
        backgroundColor: Colors.cyan,
      ),
      drawer: Drawer(child: MainDrawerConnector()),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new DoctorSearch()));
                },
                color: Colors.cyan[500],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Text(
                  "Your Home Doctor",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Comfortaa',
                    fontSize: 25,
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 130),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => new Doc()));
                },
                color: Colors.cyan[500],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Text(
                  "Form ",
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
