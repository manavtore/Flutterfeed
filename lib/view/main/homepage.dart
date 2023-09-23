import 'package:flutter/material.dart';
import 'package:flutterfeed/common/assets/appbar.dart';

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: UIcomponenets.appBar,
        body: const Center(
          child: Text(
            'Hellow World',
            style: TextStyle(
              fontSize: 39,
            ),
          ),
        ));
  }
}
