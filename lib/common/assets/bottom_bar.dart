import 'package:flutter/material.dart';
import 'package:flutterfeed/theme/pallete.dart';
import 'package:go_router/go_router.dart';

class bottom_bar extends StatelessWidget {
  const bottom_bar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Pallete.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Don\'t have an account? '),
          TextButton(
            onPressed: () => context.go('/signup'),
            child: const Text(
              'Sign up',
            ),
          ),
        ],
      ),
    );
  }
}
