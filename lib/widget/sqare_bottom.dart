// this buttoms is used to add and remove from cart

import 'package:flutter/material.dart';

class SquareButtom extends StatefulWidget {
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
  State<SquareButtom> createState() => _SquareButtomState();
}

class _SquareButtomState extends State<SquareButtom> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        height: widget.dimension,
        width: widget.dimension,
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
          color: widget.color,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: widget.child,
      ),
    );
  }
}
