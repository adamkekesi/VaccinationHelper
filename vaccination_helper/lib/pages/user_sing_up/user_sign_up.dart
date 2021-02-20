import 'package:flutter/material.dart';
import 'package:vaccination_helper/core/auth/dtos/patient_register_dto.dart';
import 'package:vaccination_helper/core/translation/translator.dart';
import 'package:vaccination_helper/helpers/exceptions/base_exception.dart';
import 'package:table_calendar/table_calendar.dart';


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

  CalendarController _calendarController;
  bool secureText = true;
  _UserSignUpState(this.isLoading, this.isSuccessful, this.exception, this.onSent, this.translator, this.payload){}
  double _scale;
  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }
  @override
  void initState() {

    _calendarController = CalendarController();


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
      body: ListView(

        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Form(
            key: _formKey,
            child:
                Center(

                  child: Container(
                    width: 300,
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      SizedBox(height: 100.0),
              _buildNameField(),SizedBox(height: 20.0),
                      _buildEmailField(),SizedBox(height: 20.0),
              _buildCityField(),SizedBox(height: 20.0),
              _buildZipcodeField(),SizedBox(height: 20.0),
              _buildAddressField(),SizedBox(height: 20.0),
                      //_buildDateOfBirthField()
                      TableCalendar(
                        //locale: Locale("hu", "HU").toString(),
                        calendarController: _calendarController,

                      )
                      ,SizedBox(height: 20.0),

                      _buildIdentityCardNumberField(),SizedBox(height: 20.0),
                      _buildSsnField(),SizedBox(height: 20.0),
                      _buildPhoneNumberField(),SizedBox(height: 20.0),
                      _buildPasswordField(),SizedBox(height: 20.0),

            ]),
                  ),
                ),
          ),
          SizedBox(height: 20.0),
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
      maxLength: 30,
      style: TextStyle(
      color: Colors.black,
      fontFamily: 'Comfortaa',
      fontSize: 15,
    ),
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
    return TextFormField(
      maxLength: 30,
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'Comfortaa',
        fontSize: 15,
      ),
      keyboardType: TextInputType.streetAddress,
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
          prefixIcon: Icon(Icons.format_list_numbered_sharp),
          hintText: "Lakcím"),
      validator: (String value){
        if(value.isEmpty){
          return 'Lakcím required';
        }
        return null;
      },
      onSaved: (String value){payload.address.address = value;},

    );
  }

  Widget _buildZipcodeField() {
    return TextFormField(
      maxLength: 10,
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'Comfortaa',
        fontSize: 15,
      ),
      keyboardType: TextInputType.numberWithOptions(),
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
          prefixIcon: Icon(Icons.format_list_numbered_sharp),
          hintText: "ZIP code"),
      validator: (String value){
        if(value.isEmpty){
          return 'ZIP code required';
        }
        return null;
      },
      onSaved: (String value){payload.address.zipCode = value;},

    );
  }

  Widget _buildCityField() {
    return TextFormField(
      maxLength: 15,
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'Comfortaa',
        fontSize: 15,
      ),
      keyboardType: TextInputType.text,
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
          prefixIcon: Icon(Icons.location_city),
          hintText: "Város"),
      validator: (String value){
        if(value.isEmpty){
          return 'Város required';
        }
        return null;
      },
      onSaved: (String value){payload.address.city = value;},

    );
  }

  Widget _buildDateOfBirthField() {
    return TextFormField(
      maxLength: 15,
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'Comfortaa',
        fontSize: 15,
      ),
      keyboardType: TextInputType.datetime,
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
          prefixIcon: Icon(Icons.date_range),
          hintText: "Születési idő"),
      validator: (String value){
        if(value.isEmpty){
          return 'Születési idő required';
        }
        return null;
      },
      onSaved: (String value){payload.dateOfBirth = DateTime.parse(value);},

    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      maxLength: 30,
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'Comfortaa',
        fontSize: 15,
      ),
      keyboardType: TextInputType.emailAddress,
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
          prefixIcon: Icon(Icons.email),
          hintText: "Email"),
      validator: (String value){
        if(value.isEmpty){
          return 'Email is required.';
        }
        if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
            return 'Please enter a valid email address.';
        }
        return null;
      },
      onSaved: (String value){payload.email = value;},

    );
  }

  Widget _buildIdentityCardNumberField() {
    return TextFormField(
      //keyboardType: TextInputType.(),

      maxLength: 8,
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'Comfortaa',
        fontSize: 15,
      ),
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
          prefixIcon: Icon(Icons.confirmation_number_sharp),
          hintText: "Személyi szám"),
      validator: (String value){
        if(value.isEmpty){
          return 'identitycard number is required.';
        }
        if(!RegExp("[0-9]{6}[a-zA-Z]{2}").hasMatch(value)){
          return 'Please enter a valid identitycard number.';
        }
        return null;
      },
      onSaved: (String value){payload.identityCardNumber = value;},

    );
  }

  Widget _buildSsnField() {
    return TextFormField(
      maxLength: 9,
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'Comfortaa',
        fontSize: 15,
      ),
      keyboardType: TextInputType.numberWithOptions(),
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
          prefixIcon: Icon(Icons.confirmation_num_rounded),
          hintText: "TAJ number"),
      validator: (String value){
        if(value.isEmpty){
          return 'TAJ number required';
        }
        if(!RegExp("[0-9]{9}").hasMatch(value)){
          return 'Please enter a valid ssn number.';
        }
        return null;
      },
      onSaved: (String value){payload.ssn = value;},

    );
  }

  Widget _buildPhoneNumberField() {
    return TextFormField(
      maxLength: 15,
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'Comfortaa',
        fontSize: 15,
      ),
      keyboardType: TextInputType.phone,
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
          prefixIcon: Icon(Icons.phone_iphone),
          hintText: "phone number"),
      validator: (String value){
        if(value.isEmpty){
          return 'phone number required';
        }
        return null;
      },
      onSaved: (String value){payload.phoneNumber = value;},

    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      maxLength: 30,
      keyboardType: TextInputType.visiblePassword,
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'Comfortaa',
        fontSize: 15,
      ),

      decoration:
      InputDecoration(enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.all(Radius.circular(100))),
          border:  OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(100))),
          prefixIcon: Icon(Icons.lock_open),
          suffixIcon: IconButton(
            icon: Icon(
                secureText ? Icons.remove_red_eye : Icons.security),
            onPressed: () {
              setState(() {
                secureText = !secureText;
              });
            },
          ),
          hintText: "Password"),
      obscureText: secureText,

      validator: (String value){
        if(value.isEmpty){
          return 'phone number required';
        }
        return null;
      },
      onSaved: (String value){payload.password = value;},

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
    if(!_formKey.currentState.validate()){
      return;
    }
    _formKey.currentState.save();
    //use the data
    print(payload.fullName);
    payload.dateOfBirth = _calendarController.selectedDay;
    print(payload.dateOfBirth);
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
