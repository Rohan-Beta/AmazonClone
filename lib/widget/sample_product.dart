import 'package:flutter/material.dart';

class SampleProduct extends StatefulWidget {
  final String url;

  const SampleProduct({super.key, required this.url});

  @override
  State<SampleProduct> createState() => _SampleProductState();
}

class _SampleProductState extends State<SampleProduct> {
  @override
  Widget build(BuildContext context) {
    return
        // GestureDetector(
        //   onTap: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => ProductDetailScreen(product: productModel),
        //       ),
        //     );
        //   },
        // child:
        AspectRatio(
      aspectRatio: 1 / 1,
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10), child: Image.network(widget.url),
          // Image.network(productModel.url),
        ),
      ),
    );
    // );
  }
}
