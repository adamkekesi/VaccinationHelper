import 'package:flutter/material.dart';

class Doc extends StatefulWidget {
  @override
  _DocState createState() => _DocState();
}

class _DocState extends State<Doc> {
  bool betegseg = false;
  bool gyogyszer = false;
  bool allergia = false;
  bool rosszullet = false;
  bool oltas = false;
  bool akut = false;
  bool laz = false;
  bool auto = false;
  bool sugar = false;
  bool gorcs = false;
  bool verzekeny = false;
  bool kapotte = false;
  bool panasz = false;
  bool terhes = false;
  bool terv = false;
  bool szopol = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Form',
          style: TextStyle(fontFamily: 'Comfortaa'),
        ),
        centerTitle: true,
        elevation: 10,
        backgroundColor: Colors.cyan,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SwitchListTile(
                title: Text(
                  'Do you have any lasting, chronic illness?',
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                  ),
                ),
                onChanged: (bool value) => setState(() => betegseg = value),
                value: betegseg,
              ),
              SizedBox(
                height: 20,
              ),
              SwitchListTile(
                title: Text(
                  'Do you take some type of medicine regularly?',
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                  ),
                ),
                onChanged: (bool value) => setState(() => gyogyszer = value),
                value: gyogyszer,
              ),
              SizedBox(
                height: 20,
              ),
              SwitchListTile(
                title: Text(
                  'Allergiás valamire?',
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                  ),
                ),
                onChanged: (bool value) => setState(() => allergia = value),
                value: allergia,
              ),
              SizedBox(
                height: 20,
              ),
              SwitchListTile(
                title: Text(
                  'Have you ever been ill after a medical examination or after a blood sample has been taken from you?',
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                  ),
                ),
                onChanged: (bool value) => setState(() => rosszullet = value),
                value: rosszullet,
              ),
              SizedBox(
                height: 20,
              ),
              SwitchListTile(
                title: Text(
                  'Have you ever had an allergic reaction to a vaccination?',
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                  ),
                ),
                onChanged: (bool value) => setState(() => oltas = value),
                value: oltas,
              ),
              SizedBox(
                height: 20,
              ),
              SwitchListTile(
                title: Text(
                  'Have you had an acute illness in the past 4 weeks?',
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                  ),
                ),
                onChanged: (bool value) => setState(() => akut = value),
                value: akut,
              ),
              SizedBox(
                height: 20,
              ),
              SwitchListTile(
                title: Text(
                  'Have you had a fever in the past 2 weeks?',
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                  ),
                ),
                onChanged: (bool value) => setState(() => laz = value),
                value: laz,
              ),
              SizedBox(
                height: 20,
              ),
              SwitchListTile(
                title: Text(
                  'Do you suffer from an autoimmune disease that is currently in it is active phase?',
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                  ),
                ),
                onChanged: (bool value) => setState(() => auto = value),
                value: auto,
              ),
              SizedBox(
                height: 20,
              ),
              SwitchListTile(
                title: Text(
                  'Did you receive a treatment that weakens your immune system or have you gotten radiation treatment in the past 3 months?',
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                  ),
                ),
                onChanged: (bool value) => setState(() => sugar = value),
                value: sugar,
              ),
              SizedBox(
                height: 20,
              ),
              SwitchListTile(
                title: Text(
                  'Did you ever have a seizure, a problem with your nervous system or paralysis of any kind?',
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                  ),
                ),
                onChanged: (bool value) => setState(() => gorcs = value),
                value: gorcs,
              ),
              SizedBox(
                height: 20,
              ),
              SwitchListTile(
                title: Text(
                  'Do you suffer from a problem with a hematopoietic organ or haemophilia?',
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                  ),
                ),
                onChanged: (bool value) => setState(() => verzekeny = value),
                value: verzekeny,
              ),
              SizedBox(
                height: 20,
              ),
              SwitchListTile(
                title: Text(
                  'Did you receive a vaccination in the past 2 weeks?',
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                  ),
                ),
                onChanged: (bool value) => setState(() => kapotte = value),
                value: kapotte,
              ),
              SizedBox(
                height: 20,
              ),
              SwitchListTile(
                title: Text(
                  'Do you have any health complaints as of now?',
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                  ),
                ),
                onChanged: (bool value) => setState(() => panasz = value),
                value: panasz,
              ),
              SizedBox(
                height: 20,
              ),
              SwitchListTile(
                title: Text(
                  'Are you currently pregnant?',
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                  ),
                ),
                onChanged: (bool value) => setState(() => terhes = value),
                value: terhes,
              ),
              SizedBox(
                height: 20,
              ),
              SwitchListTile(
                title: Text(
                  'Are you planning a pregnancy in the upcoming 2 months?',
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                  ),
                ),
                onChanged: (bool value) => setState(() => terv = value),
                value: terv,
              ),
              SizedBox(
                height: 20,
              ),
              SwitchListTile(
                title: Text(
                  'Are you currently breastfeeding?',
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                  ),
                ),
                onChanged: (bool value) => setState(() => szopol = value),
                value: szopol,
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text(
                                'Are you sure you want to save the changes?'),
                            actions: <Widget>[
                              FlatButton(onPressed: () {}, child: Text('Yes')),
                              FlatButton(onPressed: () {}, child: Text('No'))
                            ],
                          ));
                },
                color: Colors.cyan[500],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Comfortaa',
                    fontSize: 25,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
