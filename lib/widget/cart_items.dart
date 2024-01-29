// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:amazon/Mythemes/color_theme.dart';
import 'package:amazon/utilss/screen_size.dart';
import 'package:amazon/widget/product_info.dart';
import 'package:amazon/widget/rounded_bottom.dart';
import 'package:amazon/widget/sqare_bottom.dart';
import 'package:flutter/material.dart';

class CartItems extends StatefulWidget {
  const CartItems({super.key});

  @override
  State<CartItems> createState() => _CartItemsState();
}

class _CartItemsState extends State<CartItems> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MyScreenSize().getScreenSize();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      height: screenSize.height * 0.54,
      width: screenSize.width,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child:
                // GestureDetector(
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) {

                //         },
                //       ),
                //     );
                //   },
                // child:
                Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: screenSize.width / 3,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 16),
                      child: Image.network(
                        "https://m.media-amazon.com/images/I/11uufjN3lYL._SX90_SY90_.png",
                        // product.url,
                        height: screenSize.height * 2,
                        width: screenSize.width * 2,
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: ProductInfo(
                        productName: "Iphone 14",
                        cost: 100,
                        sellerName: "rohan",
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // ),
            flex: 3,
          ),
          Expanded(
            child: Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                SquareButtom(
                    child: const Icon(Icons.remove),
                    onPressed: () {},
                    color: Colors.transparent,
                    dimension: 40),
                const SizedBox(
                  width: 6,
                ),
                SquareButtom(
                    child: const Center(
                      child: Text(
                        "0",
                        style: TextStyle(color: activeCyanColor),
                      ),
                    ),
                    onPressed: () {},
                    color: Colors.white,
                    dimension: 40),
                const SizedBox(
                  width: 6,
                ),
                SquareButtom(
                    child: const Icon(Icons.add),
                    onPressed: () async {},
                    color: Colors.transparent,
                    dimension: 40),
              ],
            ),
            flex: 1,
          ),
          const SizedBox(
            height: 7,
          ),
          Expanded(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 6,
                      ),
                      RoundedButtom(onPressed: () async {}, text: "Delete"),
                      const SizedBox(
                        width: 7,
                      ),
                      RoundedButtom(onPressed: () {}, text: "Save for later"),
                      const SizedBox(
                        width: 50,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: screenSize.width * 0.1),
                        child: Text(
                          "See more like this....",
                          style: TextStyle(color: activeCyanColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }
}
