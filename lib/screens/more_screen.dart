// ignore_for_file: prefer_const_constructors, body_might_complete_normally_nullable

import 'package:amazon/Mythemes/contants.dart';
import 'package:amazon/widget/category_prodcut_more_screen.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2.2 / 3.5,
                mainAxisSpacing: 20,
              ),
              itemCount: categoriesList.length,
              itemBuilder: (context, index) {
                return CategoryProductMoreScreen(index: index);
              },
            ),
          ),
        ),
      ),
    );
  }
}
