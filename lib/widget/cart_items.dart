// ignore_for_file: sort_child_properties_last

import 'package:amazon/Mythemes/color_theme.dart';
import 'package:amazon/utilss/screen_size.dart';
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
      height: screenSize.height / 2,
      width: screenSize.width,
      decoration: const BoxDecoration(
        color: backgroundColor,
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(product: product),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenSize.width / 3,
                    // height: screenSize.height / 3,
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
                  ProductInfo(
                    productName: "Iphone 14 jsjsjdbdj jsbdjsbdjs",
                    cost: 100,
                    sellerName: //"rohan"
                        product.sellerName,
                  ),
                ],
              ),
            ),
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
                    color: backgroundColor,
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
                    onPressed: () async {
                      await MyFireStore().addProductToCart(
                        productModel: ProductModel(
                            product.url,
                            product.productName,
                            product.cost,
                            product.discount,
                            MyScreenSize().getUid(),
                            product.sellerName,
                            product.sellerUid,
                            product.rating),
                      );
                    },
                    color: backgroundColor,
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
                      RoundedButtom(
                          onPressed: () async {
                            MyFireStore().deleteCartProduct(uid: product.uid);
                          },
                          text: "Delete"),
                      const SizedBox(
                        width: 7,
                      ),
                      RoundedButtom(onPressed: () {}, text: "Save for later"),
                      const SizedBox(
                        width: 50,
                      ),
                      const Row(
                        children: [
                          Text(
                            "See more like this....",
                            style: TextStyle(color: activeCyanColor),
                          ),
                        ],
                      )
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
