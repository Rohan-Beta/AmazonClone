import 'dart:ui';

import 'package:flutter/material.dart';

class ProductCost extends StatefulWidget {
  final Color color;
  final double cost;

  const ProductCost({super.key, required this.color, required this.cost});

  @override
  State<ProductCost> createState() => _ProductCostState();
}

class _ProductCostState extends State<ProductCost> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "₹",
          style: TextStyle(
            fontSize: 18,
            fontFeatures: [
              FontFeature.subscripts(),
            ],
          ),
        ),
        Text(
          (widget.cost.toInt()).toString(),
          style: TextStyle(
            color: widget.color,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        // Text(
        //   (cost - cost.toInt()).toString(),
        //   style: const TextStyle(
        //     fontSize: 10,
        //     fontFeatures: [
        //       FontFeature.subscripts(),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
