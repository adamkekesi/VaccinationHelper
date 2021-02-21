import 'package:flutter/material.dart';

class ErrorFeedback extends StatelessWidget {
  final String msg;

  const ErrorFeedback({Key key, this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        msg,
        style: new TextStyle(fontSize: 20, color: Colors.red),
      ),
    );
  }
}
