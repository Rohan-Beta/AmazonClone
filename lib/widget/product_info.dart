// it shows the information of each product in cart screen

import 'package:amazon/Mythemes/color_theme.dart';
import 'package:amazon/utilss/screen_size.dart';
import 'package:amazon/widget/product_cost.dart';
import 'package:flutter/material.dart';

class ProductInfo extends StatefulWidget {
  final String productName;
  final num cost;
  final String sellerName;

  const ProductInfo(
      {super.key,
      required this.productName,
      required this.cost,
      required this.sellerName});

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MyScreenSize().getScreenSize();

    return SizedBox(
      width: screenSize.width / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.productName,
              maxLines: 2,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                letterSpacing: 0.6,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(
            height: 11,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: ProductCost(color: Colors.black, cost: widget.cost),
          ),
          const SizedBox(
            height: 15,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Seller: ",
                    style: TextStyle(color: Colors.grey[700], fontSize: 14),
                  ),
                  TextSpan(
                    text: widget.sellerName,
                    style: const TextStyle(
                      color: activeCyanColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
