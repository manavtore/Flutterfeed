import 'package:flutter/material.dart';
import 'package:flutterfeed/common/Button/login_button.dart';
import 'package:flutterfeed/common/Button/or_bar.dart';
import 'package:flutterfeed/common/Button/sign_in_button.dart';
import 'package:flutterfeed/common/Reusables/appbar.dart';
import 'package:flutterfeed/common/assets/bottom_bar.dart';

class signinpage extends StatefulWidget {
  const signinpage({super.key});

  @override
  State<signinpage> createState() => _signinpageState();
}

class _signinpageState extends State<signinpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIcomponenets.appBar,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 240,
              ),
              const Text(
                'Welcome back! Log in to see the latest',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Signinbutton(),
              const SizedBox(
                height: 10,
              ),
              orBar(),
              const SizedBox(
                height: 10,
              ),
              const loginbutton(),
              const SizedBox(
                height: 100,
              ),
              const bottom_bar()
            ],
          ),
        ),
      ),
    );
  }
}
