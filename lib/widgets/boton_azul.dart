import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {

  final Function()? onPress;
  final String text;

  const BotonAzul({required this.onPress, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: this.onPress,
        style: ElevatedButton.styleFrom(
            elevation: 2, primary: Colors.blue, shape: StadiumBorder()),
        child: Container(
          width: double.maxFinite,
          height: 55,
          child: Center(
            child: Text(
              this.text,
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
        ));
  }
}
