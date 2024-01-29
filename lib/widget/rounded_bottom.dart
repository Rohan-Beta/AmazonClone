// this buttoms is used to delete and save for later in cart

import 'package:flutter/material.dart';

class RoundedButtom extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const RoundedButtom({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: Text(text),
      ),
    );
  }
}
