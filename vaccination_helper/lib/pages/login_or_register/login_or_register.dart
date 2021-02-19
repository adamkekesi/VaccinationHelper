import 'package:flutter/material.dart';


class Button extends StatefulWidget {
  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  double _scale;
  @override
  void initState() {
   _controller = AnimationController(
     vsync: this,
     duration: Duration(milliseconds: 200),
     lowerBound: 0.0,
     upperBound: 0.1
   )..addListener(() {setState(() {

   });});
  }


  @override
  Widget build(BuildContext context) {
    _scale = 1-_controller.value;
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [Container(
                width: 300,
                  height: 60,
                child: _textfieldUi(
                  hintText: "Név",
                  icon: Icons.account_circle
                )
              ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: 300,
                    height: 60,
                    child: _textfieldUi(
                        hintText: "Lakcím",
                        icon: Icons.place_outlined
                    )
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: 300,
                    height: 60,
                    child: _textfieldUi(
                        hintText: "Születési idő",
                        icon: Icons.date_range
                    )
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: 300,
                    height: 60,
                    child: _textfieldUi(
                        hintText: "Email",
                        icon: Icons.email
                    )
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: 300,
                    height: 60,
                    child: _textfieldUi(
                        hintText: "Személyi szám",
                        icon: Icons.confirmation_num
                    )
                ),SizedBox(
                  height: 10,
                ),
                Container(
                    width: 300,
                    height: 60,
                    child: _textfieldUi(
                        hintText: "TAJ szám",
                        icon: Icons.confirmation_number_sharp
                    )
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: 300,
                    height: 60,
                    child: _textfieldUi(
                        hintText: "telefonszám",
                        icon: Icons.phone_iphone
                    )
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: 300,
                    height: 60,
                    child: _textfieldUi(
                        hintText: "Jelszó",
                        icon: Icons.lock_open
                    )
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: 300,
                    height: 60,
                    child: _textfieldUi(
                        hintText: "Jelszó újra",
                        icon: Icons.lock_open
                    )
                ),
              ]
            ),
            Text('tap on the button below'),
            SizedBox(height: 20.0,),
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
              borderRadius: BorderRadius.all(Radius.circular(100))
          ),
          prefixIcon: Icon(icon),
          hintText: hintText

      ),

    );
  }
  Widget get _animatedButtonUi => Container(
    height: 60,
    width: 300,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),

      color: Colors.cyan),
    child: Center(
      child: Text("Küldés",
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          fontSize: 30),
      ),
    )
    );
  void _onTapDown(TapDownDetails details){
    _controller.forward();

  }
  void _onTapUp(TapUpDetails details){
    _controller.reverse();

  }

}
