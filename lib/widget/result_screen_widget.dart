// ignore_for_file: prefer_const_constructors

import 'package:amazon/MyModels/product_model.dart';
import 'package:amazon/screens/product_detail_screen.dart';
import 'package:amazon/utilss/next_screen.dart';
import 'package:amazon/utilss/screen_size.dart';
import 'package:amazon/widget/product_cost.dart';
import 'package:amazon/widget/rating_star_widget.dart';
import 'package:flutter/material.dart';

class ResultWidget extends StatefulWidget {
  final ProductModel product;

  const ResultWidget({super.key, required this.product});

  @override
  State<ResultWidget> createState() => _ResultWidgetState();
}

class _ResultWidgetState extends State<ResultWidget> {
  Size screenSize = MyScreenSize().getScreenSize();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        nextScreen(context, ProductDetailScreen(product: widget.product));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: screenSize.width / 3,
              child: Image.network(widget.product.url),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 7),
              child: Text(
                widget.product.productName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5, top: 7),
              child: Row(
                children: [
                  SizedBox(
                    width: screenSize.width / 5,
                    child: FittedBox(
                      child: RatingStar(
                        rating: widget.product.rating,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            SizedBox(
              height: 19,
              child: FittedBox(
                child: ProductCost(
                  color: Colors.black,
                  cost: widget.product.cost,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
