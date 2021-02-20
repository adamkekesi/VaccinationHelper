import 'package:flutter/material.dart';

String name;
String address;
String zipCode;
String city;
String dateOfBirth;
String email;
String identityCardNumber;
String ssn;
String phoneNumber;
String password;

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

Widget _buildNameField() {
  return TextField(
    decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.all(Radius.circular(100))),
        prefixIcon: Icon(Icons.account_circle),
        hintText: "Név"),
  );
}

Widget _buildAddressField() {
  return null;
}

Widget _buildZipcodeField() {
  return null;
}

Widget _buildCityField() {
  return null;
}

Widget _buildDateOfBirthField() {
  return null;
}

Widget _buildEmailField() {
  return null;
}

Widget _buildIdentityCardNumberField() {
  return null;
}

Widget _buildSsnField() {
  return null;
}

Widget _buildPhoneNumberField() {
  return null;
}

Widget _buildPasswordField() {
  return null;
}

class UserSignUp extends StatefulWidget {
  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<UserSignUp>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  double _scale;
  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 200),
        lowerBound: 0.0,
        upperBound: 0.1)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Páciens adatai',
          style: TextStyle(fontFamily: 'Comfortaa'),
        ),
        centerTitle: true,
        elevation: 10,
        backgroundColor: Colors.cyan,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Form(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              _buildNameField() /*
                Container(
                    width: 300,
                    height: 60,
                    child: _textfieldUi(
                        hintText: "Név", icon: Icons.account_circle)),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: 300,
                    height: 60,
                    child: _textfieldUi(
                        hintText: "Lakcím", icon: Icons.place_outlined)),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: 300,
                    height: 60,
                    child: _textfieldUi(
                        hintText: "Születési idő", icon: Icons.date_range)),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: 300,
                    height: 60,
                    child: _textfieldUi(hintText: "Email", icon: Icons.email)),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: 300,
                    height: 60,
                    child: _textfieldUi(
                        hintText: "Személyi szám", icon: Icons.confirmation_num)),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: 300,
                    height: 60,
                    child: _textfieldUi(
                        hintText: "TAJ szám",
                        icon: Icons.confirmation_number_sharp)),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: 300,
                    height: 60,
                    child: _textfieldUi(
                        hintText: "Telefonszám", icon: Icons.phone_iphone)),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: 300,
                    height: 60,
                    child:
                        _textfieldUi(hintText: "Jelszó", icon: Icons.lock_open)),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: 300,
                    height: 60,
                    child: _textfieldUi(
                        hintText: "Jelszó újra", icon: Icons.lock_open)),
              */
            ]),
          ),
          Text('tap on the button below'),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: GestureDetector(
              onTapDown: _onTapDown,
              onTapUp: _onTapUp,
              child: Transform.scale(
                scale: _scale,
                child: _animatedButtonUi,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _textfieldUi({String hintText, IconData icon}) {
    return TextField(
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.greenAccent),
              borderRadius: BorderRadius.all(Radius.circular(100))),
          prefixIcon: Icon(icon),
          hintText: hintText),
    );
  }

  Widget get _animatedButtonUi => Container(
      height: 60,
      width: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0), color: Colors.cyan),
      child: Center(
        child: Text(
          "Küldés",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
              fontFamily: 'Comfortaa'),
        ),
      ));
  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
