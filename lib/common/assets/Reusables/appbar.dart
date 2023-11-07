import 'package:flutter/material.dart';
import 'package:flutterfeed/theme/theme.dart';

class UIcomponenets {
  static AppBar appBar = AppBar(
      centerTitle: true,
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

  static List<Widget> bottomTabBArPages = [
    const Text('Feed Screen'),
  ];
}
