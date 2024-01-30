// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:amazon/MyModels/product_model.dart';
import 'package:amazon/Mythemes/color_theme.dart';
import 'package:amazon/provider/sign_in_provider.dart';
import 'package:amazon/utilss/screen_size.dart';
import 'package:amazon/widget/cart_items.dart';
import 'package:amazon/widget/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  RoundedLoadingButtonController cartController =
      RoundedLoadingButtonController();

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
      appBar: MySearchBar(isReadOnly: true, hasBackButtom: false),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: backgroundGradient,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                width: screenSize.width,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 10, bottom: 4, top: 4),
                      child: Icon(Icons.location_on_outlined),
                    ),
                    Text(
                      "Deliver in - ${sp.address}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              CartItems(
                product: ProductModel(
                    "https://m.media-amazon.com/images/I/51QISbJp5-L._SX3000_.jpg",
                    "Iphone",
                    100,
                    10,
                    "123456789",
                    "Rohan",
                    "8017202787",
                    4),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: RoundedLoadingButton(
                  controller: cartController,
                  successColor: Colors.yellow,
                  color: Colors.yellow,
                  width: screenSize.width * 0.4,
                  onPressed: () {},
                  child: Wrap(
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        size: 20,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Proceed to (n) items",
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
            ],
          ),
        ),
      ),
    );
  }
}
