// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, unnecessary_string_interpolations

import 'package:amazon/MyModels/product_model.dart';
import 'package:amazon/utilss/screen_size.dart';
import 'package:flutter/material.dart';

class ProductDescription extends StatefulWidget {
  final ProductModel productModel;

  const ProductDescription({super.key, required this.productModel});

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MyScreenSize().getScreenSize();

    return Scaffold(
      appBar: AppBar(
        title: Text("Description"),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: screenSize.width,
              height: screenSize.height * 0.9,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text("${widget.productModel.description.toString()}"),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
