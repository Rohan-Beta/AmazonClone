import 'package:amazon/Mythemes/color_theme.dart';
import 'package:amazon/utilss/screen_size.dart';
import 'package:flutter/material.dart';

class ProductsView extends StatefulWidget {
  final String title;
  final List<Widget> children;

  const ProductsView({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MyScreenSize().getScreenSize();
    double height = screenSize.width * 0.4;
    double titleHeight = 25;

    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      height: height,
      width: screenSize.width,
      color: Colors.transparent,
      // color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: titleHeight,
            child: Row(
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 14),
                  child: Text(
                    "Show more",
                    style: TextStyle(color: activeCyanColor),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height - (titleHeight + 10 + 16),
            width: screenSize.width,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: widget.children,
            ),
          )
        ],
      ),
    );
  }
}
