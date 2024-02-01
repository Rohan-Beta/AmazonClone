// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:amazon/MyModels/product_model.dart';
import 'package:amazon/Mythemes/color_theme.dart';
import 'package:amazon/provider/sign_in_provider.dart';
import 'package:amazon/screens/login_screen.dart';
import 'package:amazon/screens/product_order_screen.dart';
import 'package:amazon/screens/sell_product_screen.dart';
import 'package:amazon/utilss/next_screen.dart';
import 'package:amazon/utilss/screen_size.dart';
import 'package:amazon/widget/account_app_bar.dart';
import 'package:amazon/widget/product_view.dart';
import 'package:amazon/widget/sample_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  RoundedLoadingButtonController signOutController =
      RoundedLoadingButtonController();

  RoundedLoadingButtonController sellController =
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
    final sp = context.watch<SignInProvider>();
    Size screenSize = MyScreenSize().getScreenSize();

    return Scaffold(
      appBar: AccountAppBar(),
      body: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                height: 40,
                width: screenSize.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: backgroundGradient,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Container(
                  height: 40,
                  width: screenSize.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.white.withOpacity(0),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Hello, ",
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 22,
                                ),
                              ),
                              TextSpan(
                                text: "${sp.name}",
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 45),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.settings),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  // sign out

                  RoundedLoadingButton(
                    controller: signOutController,
                    successColor: Colors.orange,
                    color: Colors.orange,
                    width: screenSize.width * 0.4,
                    onPressed: () {
                      sp.userSignOut();
                      nextScreenReplace(context, LogInScreen());
                    },
                    child: Wrap(
                      children: [
                        Icon(
                          FontAwesomeIcons.signOut,
                          size: 20,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Sign Out",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  // sell
                  RoundedLoadingButton(
                    controller: sellController,
                    successColor: Colors.yellow,
                    color: Colors.yellow,
                    width: screenSize.width * 0.4,
                    onPressed: () {
                      nextScreen(context, SellProductScreen());
                    },
                    child: Wrap(
                      children: [
                        Icon(
                          Icons.sell,
                          size: 20,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Sell",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("users")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("orders")
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container();
                      } else {
                        List<Widget> children = [];

                        for (int i = 0;
                            i < snapshot.data!.docs.length;
                            i += 1) {
                          ProductModel model = ProductModel.getModelFromJson(
                              snapshot.data!.docs[i].data());
                          children.add(SampleProduct(productModel: model));
                        }
                        return ProductsView(
                            title: "Your Orders", children: children);
                      }
                    },
                  ),
                  // ProductsView(
                  //   title: "Your Orders",
                  //   children: [
                  //     SampleProduct(
                  //       productModel: ProductModel(
                  //           "https://m.media-amazon.com/images/I/51QISbJp5-L._SX3000_.jpg",
                  //           "Iphone",
                  //           100,
                  //           10,
                  //           "123456789",
                  //           "Rohan",
                  //           "8017202787",
                  //           4,
                  //           "description"),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: screenSize.width * 0.38,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow),
                      onPressed: () {
                        nextScreen(context, ProductOrderScreen());
                      },
                      child: Wrap(
                        children: [
                          Icon(
                            Icons.shopping_cart_checkout,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Orders",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
