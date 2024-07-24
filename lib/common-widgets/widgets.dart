import 'package:flutter/material.dart';

class CustonContainer extends StatelessWidget {
  CustonContainer({this.child});

  var child;

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Container(
      width: mq.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xffFF1883), Color(0xffFF6B38)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: child,
    );
  }
}
