import 'package:flutter/material.dart';

double screenWidth(context) {
  return MediaQuery.of(context).size.width;
}

///////////////////////////////////////////////////////////

double screenHeight(context) {
  return MediaQuery.of(context).size.height;
}

double keyboardHeight(context) {
  return MediaQuery.of(context).viewInsets.bottom;
}

const kPrimaryColor = Color(0xff176B87);


const List<Color> appColors = [
  Color(0xff00BCD4),
  Color(0xff3887BE),
  Color(0xff38419D),
  Color(0xff176B87),
  Color(0xffB4D4FF),
];