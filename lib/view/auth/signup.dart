import 'package:flutter/material.dart';
import 'package:flutterfeed/common/assets/Button/Or_bar.dart';
import 'package:flutterfeed/common/assets/Button/create_button.dart';
import 'package:flutterfeed/common/assets/Button/login_button.dart';
import 'package:flutterfeed/common/assets/Button/sign_in_button.dart';
import 'package:flutterfeed/common/assets/Reusables/appbar.dart';
import 'package:flutterfeed/common/assets/bottom_bar.dart';
import 'package:flutterfeed/view/auth/create_account.dart';

class sign_up extends StatefulWidget {
  const sign_up({super.key});

  @override
  State<sign_up> createState() => _sign_upState();
}

class _sign_upState extends State<sign_up> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIcomponenets.appBar,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 240,
                ),
                const Text(
                  'See What\'s happening in the world right now.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35,
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                const Signinbutton(),
                const SizedBox(
                  height: 10,
                ),
                orBar(),
                const SizedBox(
                  height: 10,
                ),
                const create_button(),
                const SizedBox(
                  height: 100,
                ),
                const bottom_bar()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
