import 'package:amazon/MyModels/product_model.dart';
import 'package:amazon/screens/product_detail_screen.dart';
import 'package:amazon/utilss/next_screen.dart';
import 'package:flutter/material.dart';

class SampleProduct extends StatefulWidget {
  // final String url;
  final ProductModel productModel;

  const SampleProduct({super.key, required this.productModel});

  @override
  State<SampleProduct> createState() => _SampleProductState();
}

class _SampleProductState extends State<SampleProduct> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        nextScreen(context, ProductDetailScreen(product: widget.productModel));
      },
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child:
                //  Image.network(widget.url),
                Image.network(widget.productModel.url),
          ),
        ),
      ),
    );
  }
}
