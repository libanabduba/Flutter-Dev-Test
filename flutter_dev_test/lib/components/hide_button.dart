import 'package:flutter/material.dart';

class HideButton extends StatelessWidget {

  final VoidCallback onPressed;
  final icon;

  const HideButton({super.key, required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: icon,
    );
  }
}