import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button({super.key, required this.text, required this.onPressed});
  final String text;
  VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text(text));
  }
}
