// this buttoms is used to add and remove from cart

import 'package:flutter/material.dart';

class SquareButtom extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color color;
  final double dimension;

  const SquareButtom(
      {super.key,
      required this.child,
      required this.onPressed,
      required this.color,
      required this.dimension});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: dimension,
        width: dimension,
        // decoration: ShapeDecoration(
        //   shape: RoundedRectangleBorder(
        //     side: const BorderSide(
        //       color: Colors.grey,
        //       width: 1,
        //     ),
        //     borderRadius: BorderRadius.circular(2),
        //   ),
        // ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: child,
      ),
    );
  }
}
