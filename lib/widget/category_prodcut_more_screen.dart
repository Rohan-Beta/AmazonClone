// ignore_for_file: prefer_const_constructors

import 'package:amazon/Mythemes/contants.dart';
import 'package:flutter/material.dart';

class CategoryProductMoreScreen extends StatefulWidget {
  final int index;

  const CategoryProductMoreScreen({super.key, required this.index});

  @override
  State<CategoryProductMoreScreen> createState() =>
      _CategoryProductMoreScreenState();
}

class _CategoryProductMoreScreenState extends State<CategoryProductMoreScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => MyResultScreen(
        //       query: categoriesList[index],
        //     ),
        //   ),
        // );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                categoryLogos[widget.index],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                categoriesList[widget.index],
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
