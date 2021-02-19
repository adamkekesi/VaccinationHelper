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
            Text('tap on the button below'),
            SizedBox(height: 20.0,),
            Center(
              child: GestureDetector(
                onTapDown: _onTapDown,
                  onTapUp: _onTapUp,
              child: Transform.scale(
                  scale: _scale,
              child: _animatedButtonUi,),),
            )
          ],
        ),
      ),
    );
  }
  Widget get _animatedButtonUi => Container(
    height: 70,
    width: 300,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),

      color: Colors.cyan),
    child: Center(
      child: Text("Tap",
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
