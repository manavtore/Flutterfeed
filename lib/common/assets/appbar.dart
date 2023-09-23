import 'package:flutter/material.dart';
import 'package:flutterfeed/theme/theme.dart';

class UIcomponenets {
  static AppBar appBar = AppBar(
      title: Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Image.asset(
        'assets/Twitterlogo.png',
        height: 25,
        color: Pallete.whiteColor,
      ),
    ),
  ));
}
