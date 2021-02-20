import 'package:flutter/material.dart';
import 'package:vaccination_helper/core/auth/dtos/patient_register_dto.dart';
import 'package:vaccination_helper/core/translation/translator.dart';
import 'package:vaccination_helper/helpers/exceptions/base_exception.dart';


final GlobalKey<FormState> _formKey = GlobalKey<FormState>();




typedef void SendFunction();

class UserSignUp extends StatefulWidget {
  // are we currently waiting for the server's response?
  final bool isLoading;
  // should we show a success message?
  final bool isSuccessful;
  // if the registration failed, this will be the error
  final BaseException exception;
  // function to send the registration to the server
  final SendFunction onSent;

  final Translator translator;

  final PatientRegisterDto payload;

  UserSignUp(
      {this.isLoading,
      this.isSuccessful,
      this.exception,
      this.onSent,
      this.translator,
      this.payload});

  @override
  _UserSignUpState createState() => _UserSignUpState(isLoading, isSuccessful, exception, onSent, translator, payload);
}

class _UserSignUpState extends State<UserSignUp>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  // are we currently waiting for the server's response?
  final bool isLoading;
  // should we show a success message?
  final bool isSuccessful;
  // if the registration failed, this will be the error
  final BaseException exception;
  // function to send the registration to the server
  final SendFunction onSent;

  final Translator translator;

  final PatientRegisterDto payload;

  _UserSignUpState(this.isLoading, this.isSuccessful, this.exception, this.onSent, this.translator, this.payload){}
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
            key: _formKey,
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
  Widget _buildNameField() {
    return TextFormField(
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.all(Radius.circular(100))),
          border:  OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(100))),
          prefixIcon: Icon(Icons.account_circle),
          hintText: "Név"),
      validator: (String value){
        if(value.isEmpty){
          return 'Name is required.';
        }
        return null;
      },
      onSaved: (String value){payload.fullName = value;},

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
    if(!_formKey.currentState.validate()){
      return;
    }
    _formKey.currentState.save();
    //use the data
    print(payload.fullName);
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
