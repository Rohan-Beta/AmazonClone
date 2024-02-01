// ignore_for_file: use_build_context_synchronously, sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:amazon/MyLayouts/screen_layout.dart';
import 'package:amazon/MyModels/product_model.dart';
import 'package:amazon/Mythemes/color_theme.dart';
import 'package:amazon/Mythemes/contants.dart';
import 'package:amazon/provider/sign_in_provider.dart';
import 'package:amazon/screens/full_review_screen.dart';
import 'package:amazon/screens/product_description.dart';
import 'package:amazon/utilss/next_screen.dart';
import 'package:amazon/utilss/screen_size.dart';
import 'package:amazon/utilss/snack_bar.dart';
import 'package:amazon/widget/product_cost.dart';
import 'package:amazon/widget/rating_star_widget.dart';
import 'package:amazon/widget/review_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MyScreenSize().getScreenSize();
    final sp = context.watch<SignInProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Amazon Clone"),
        backgroundColor: backgroundColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black45,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: kAppBarHeight / 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  widget.product.sellerName,
                                  style: const TextStyle(
                                      color: activeCyanColor, fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  widget.product.productName,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          RatingStar(rating: widget.product.rating),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 5),
                      child: Container(
                        // decoration: const BoxDecoration(
                        color: Colors.transparent,
                        height: screenSize.height * 0.5,
                        width: screenSize.width * 0.86,
                        child: FittedBox(
                          child: Image.network(widget.product.url),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        ProductCost(
                          color: Colors.black,
                          cost: widget.product.cost,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                          height: screenSize.height / 24,
                          child: Image.network(
                              "https://m.media-amazon.com/images/I/51Iht+dUqDL._AC_UF1000,1000_QL80_.jpg"),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),

                    // buy now

                    SizedBox(
                      height: 40,
                      width: 190,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange),
                        onPressed: () async {
                          await sp.addProductToOrder(model: widget.product);
                          openSnackBar(
                              context, "Will be delivered soon", Colors.yellow);
                          nextScreen(context, ScreenLayout());
                        },
                        child: Wrap(
                          children: [
                            Icon(
                              FontAwesomeIcons.dollarSign,
                              size: 20,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              "Buy now",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    // add to cart

                    SizedBox(
                      height: 40,
                      width: 190,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow),
                        onPressed: () async {
                          await sp.addProductToCart(
                              productModel: widget.product);
                          openSnackBar(
                              context, "Item added to cart", Colors.yellow);
                        },
                        child: Wrap(
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              size: 20,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              "Add to cart",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // drop a review

                        SizedBox(
                          width: 150,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellow),
                            child: const Text(
                              "Drop a review",
                              maxLines: 1,
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return ReviewDialog(
                                    productUid: widget.product.uid,
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 100,
                        ),
                        TextButton(
                          onPressed: () {
                            nextScreen(
                              context,
                              ProductDescription(
                                productModel: widget.product,
                              ),
                            );
                          },
                          child: const Row(
                            children: [
                              Text("details "),
                              Icon(Icons.info),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      decoration: BoxDecoration(color: Colors.grey[400]!),
                      width: screenSize.width,
                      child: TextButton(
                        child: const Row(
                          children: [
                            Text("See full reviews"),
                            Icon(Icons.star),
                          ],
                        ),
                        onPressed: () {
                          nextScreen(
                            context,
                            FullReviewScreen(productModel: widget.product),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
