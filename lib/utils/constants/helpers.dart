import 'package:flutter/material.dart';

class PPHelpers{
  PPHelpers._();

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}