import 'package:flutter/material.dart';

class Labels extends StatelessWidget {

  final String route;
  final String question1;
  final String question2;


  const Labels({
    
    required this.route, 
    required this.question1, 
    required this.question2});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Text(
            this.question1,
            style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: (){
              Navigator.pushReplacementNamed(context, this.route);
            },
            child: Text(
              this.question2,
              style: TextStyle(
                  color: Colors.blue[600],
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          
        ],
      ),
    );
  }
}
