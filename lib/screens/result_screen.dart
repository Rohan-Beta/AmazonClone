// ignore_for_file: prefer_const_constructors

import 'package:amazon/MyModels/product_model.dart';
import 'package:amazon/widget/result_screen_widget.dart';
import 'package:amazon/widget/search_bar.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  final String query;

  const ResultScreen({super.key, required this.query});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MySearchBar(isReadOnly: false, hasBackButtom: true),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Showing result for ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                      TextSpan(
                        text: widget.query,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return ResultWidget(
                      product: ProductModel(
                        "https://m.media-amazon.com/images/I/51QISbJp5-L._SX3000_.jpg",
                        "Iphone",
                        100,
                        10,
                        "123456789",
                        "Rohan",
                        "8017202787",
                        4,
                        "description of product",
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
