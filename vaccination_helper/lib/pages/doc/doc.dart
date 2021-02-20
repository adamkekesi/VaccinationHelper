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
          'Nyilatkozat',
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
                  'Van tartós, krónikus betegsége?',
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
                  'Szed valamilyen gyógyszer rendszeresen?',
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
                  'Volt már rosszul vizsgálat vagy vérvétel során?',
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
                  'Védőoltás beadását után volt-e allergiás/heves reakciója?',
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
                  'Volt-e valamilyen akut betegségeaz elmúlt 4 hétben?',
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
                  'Volt-e lázas beteg az elmúlt 2 hétben?',
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
                  'Szenved-e olyan autoimmun betegségben, melynek épp aktív fázisa zajlik?',
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
                  'Az elmúlt 3 hónapban kapott-e az immunrendszerét gyengítő kezelést, ill. sugárkezelést?',
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
                  'Volt-e valaha görcsrohama, idegrendszeri problémája, bénulása?',
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
                  'Szenved-e vérképzőszervi betegségben, fokozott vérzékenységben?',
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
                  'Kapott-e védőoltást az elmúlt 2hétben?',
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
                  'Jelenleg van-e bármilyen panasza?',
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
                  'Jelenleg várandós-e?',
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
                  'Tervez-e várandósságot 2 hónapon belül?',
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
                  'Szoptat-e?',
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
                onPressed: () {},
                color: Colors.cyan[500],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Text(
                  "Mentés",
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
