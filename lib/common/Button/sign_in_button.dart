import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfeed/common/pngs/constants.dart';
import 'package:flutterfeed/controller/auth_controller.dart';

class Signinbutton extends ConsumerWidget {
  const Signinbutton({super.key});

  void signinWithGoogle(WidgetRef ref) {
    ref.read(AuthControllerProvider).signinWithGoogle();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton.icon(
          icon: Image.asset(
            constants.Googlelogo,
            height: 25,
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Colors.black,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
          ),
          onPressed: () => signinWithGoogle(ref),
          label: const Text(
            'Continue with Google',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
