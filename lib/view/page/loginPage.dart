// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterfeed/common/Reusables/appbar.dart';
import 'package:flutterfeed/theme/pallete.dart';
import 'package:flutterfeed/view/main/homescreen.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  var emailid = TextEditingController();
  var pswd = TextEditingController();

  Future<bool> loginwithemailandpassword() async {
    var auth = FirebaseAuth.instance;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailid.text, password: pswd.text);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (kDebugMode) {
          print('user not found');
        }
      } else if (e.code == 'wrong-password') {
        if (kDebugMode) {
          print('wrong password');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      appBar: UIcomponenets.appBar,
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              onChanged: (value) {
                emailid.text = value;
              },
              controller: emailid,
              textInputAction: TextInputAction.go,
              inputFormatters: [LengthLimitingTextInputFormatter(50)],
              decoration: const InputDecoration(
                  hintText: 'email address',
                  hintMaxLines: 50,
                  hintStyle: TextStyle(
                    color: Pallete.whiteColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Pallete.whiteColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Pallete.whiteColor))),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              onChanged: (value) {
                pswd.text = value;
              },
              controller: pswd,
              inputFormatters: [LengthLimitingTextInputFormatter(50)],
              decoration: const InputDecoration(
                  hintText: 'password',
                  hintMaxLines: 50,
                  hintStyle: TextStyle(
                    color: Pallete.whiteColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Pallete.whiteColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Pallete.whiteColor))),
              obscureText: true,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (await loginwithemailandpassword()) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const homescreen()));
                  }
                },
                child: const Text('log in'))
          ],
        ),
      ),
    );
  }
}
