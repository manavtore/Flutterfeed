import 'package:flutter/material.dart';

Widget orBar() {
  return const Row(
    children: [
      Expanded(
        child: Divider(
          color: Colors.grey,
          height: 20,
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          'OR',
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Expanded(
        child: Divider(
          color: Colors.grey,
          height: 20,
        ),
      ),
    ],
  );
}
