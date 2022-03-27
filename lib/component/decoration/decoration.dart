import 'package:flutter/material.dart';

class DecorationWidege {
  static decation(Color color,double radius) {
    return new BoxDecoration(
      shape: BoxShape.rectangle,
     
      borderRadius: BorderRadius.circular(radius),
      color: color,
    );
  }
}
