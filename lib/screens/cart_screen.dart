// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:amazon/MyLayouts/screen_layout.dart';
import 'package:amazon/MyModel/user_info_model.dart';
import 'package:amazon/MyModels/product_model.dart';
import 'package:amazon/Mythemes/color_theme.dart';
import 'package:amazon/provider/sign_in_provider.dart';
import 'package:amazon/utilss/next_screen.dart';
import 'package:amazon/utilss/screen_size.dart';
import 'package:amazon/utilss/snack_bar.dart';
import 'package:amazon/widget/cart_items.dart';
import 'package:amazon/widget/search_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
            // Padding(
            //   padding: const EdgeInsets.only(top: 20, bottom: 20),
            //   child: RoundedLoadingButton(
            //     controller: cartController,
            //     successColor: Colors.yellow,
            //     color: Colors.yellow,
            //     width: screenSize.width * 0.4,
            //     onPressed: () {},
            //     child: Wrap(
            //       children: [
            //         Icon(
            //           Icons.shopping_cart,
            //           size: 20,
            //           color: Colors.black,
            //         ),
            //         SizedBox(
            //           width: 5,
            //         ),
            //         Text(
            //           "Proceed to (n) items",
            //           style: TextStyle(
            //             fontSize: 15,
            //             fontWeight: FontWeight.w500,
            //             color: Colors.black,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection("cart")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container();
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        ProductModel model = ProductModel.getModelFromJson(
                            snapshot.data!.docs[index].data());
                        return CartItems(product: model);
                      },
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("cart")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ElevatedButton(
                            onPressed: () {}, child: Text("No items"));
                      } else {
                        return RoundedLoadingButton(
                          controller: cartController,
                          successColor: Colors.yellow,
                          color: Colors.yellow,
                          width: 150,
                          onPressed: () async {
                            await SignInProvider().buyAllProductsInCarts(
                              userInfo: UserInfoModel(
                                  sp.name!, sp.address!, sp.uid!, sp.pincode!),
                            );

                            openSnackBar(context, "thank you for purchasing",
                                Colors.yellow);
                            nextScreen(
                              context,
                              ScreenLayout(),
                            );
                          },
                          child: Wrap(
                            children: [
                              Icon(
                                Icons.shopping_cart,
                                size: 20,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Buy ${snapshot.data!.docs.length} items",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
