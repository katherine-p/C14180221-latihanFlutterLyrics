import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  String textbutton;
  final GestureTapCallback pressbutton;
  @override
  _MyButtonState createState() => _MyButtonState(this.textbutton, pressbutton: pressbutton);
  MyButton(this.textbutton, {@required this.pressbutton});
}

class _MyButtonState extends State<MyButton> {
  String textbutton;
  final GestureTapCallback pressbutton;

  _MyButtonState(this.textbutton, {@required this.pressbutton});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ElevatedButton(
          onPressed: pressbutton,
          style: ElevatedButton.styleFrom(
            primary: Colors.purple[100],
            onPrimary: Colors.white
          ),
          child: Text(textbutton),
        )
      ]
    );  
  }
}