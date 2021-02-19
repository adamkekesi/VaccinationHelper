import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vaccination_helper/core/translation/translator.dart';
import 'package:vaccination_helper/pages/loading_page/loading.dart';

class AccountType extends StatelessWidget {
  AccountType({this.translator});
  Translator translator;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Felhasználó',
          style: TextStyle(fontFamily: 'Comfortaa'),
        ),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 80),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new Loading()));
              },
              color: Colors.cyan[500],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Text(
                "Páciens",
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
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new Loading()));
              },
              color: Colors.cyan[500],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Text(
                "Orvos",
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
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              onPressed: () {},
              color: Colors.cyan[500],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Column(children: [
                Text(
                  "Adminisztrátor",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Comfortaa',
                    fontSize: 25,
                  ),
                ),
                Text(
                  "(*hamarosan)",
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
