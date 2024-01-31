// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:amazon/MyLayouts/screen_layout.dart';
import 'package:amazon/Mythemes/color_theme.dart';
import 'package:amazon/utilss/next_screen.dart';
import 'package:amazon/utilss/screen_size.dart';
import 'package:flutter/material.dart';

class ProductOrderScreen extends StatefulWidget {
  const ProductOrderScreen({super.key});

  @override
  State<ProductOrderScreen> createState() => _ProductOrderScreenState();
}

class _ProductOrderScreenState extends State<ProductOrderScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MyScreenSize().getScreenSize();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        leading: IconButton(
            onPressed: () {
              nextScreen(context, ScreenLayout());
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text("Order Requests"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 5,
                  right: 2,
                ),
                child: Container(
                  height: screenSize.height,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: ListView.builder(
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            "Order: Black Dress",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text("name , address"),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.check),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
