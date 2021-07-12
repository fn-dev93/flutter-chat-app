import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {

  final IconData icon;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool isPassword;

  const CustomInput({Key key, 
  
  this.icon, 
  this.placeholder, 
  this.textController, 
  this.keyboardType = TextInputType.text, 
  this.isPassword = false
  
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
            padding: EdgeInsets.only(top: 5, left: 5,bottom: 5, right: 20),
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: Offset(0, 5),
                  blurRadius: 5)
              ]
            ),
            child: TextField(
              obscureText: this.isPassword,
              controller: this.textController,
              autocorrect: false,
              keyboardType: this.keyboardType,
              decoration: InputDecoration(
                prefixIcon: Icon(this.icon),
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                hintText: this.placeholder,
              ),
            ),
          );
  }
}