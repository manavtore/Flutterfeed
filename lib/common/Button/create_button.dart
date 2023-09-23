import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfeed/theme/pallete.dart';
import 'package:flutterfeed/view/page/create_account.dart';

class create_button extends ConsumerWidget {
  const create_button({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Pallete.whiteColor,
            foregroundColor: Pallete.searchBarColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const create_account()));
          },
          child: const Text(
            'Create account',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
