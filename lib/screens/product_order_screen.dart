// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:amazon/MyLayouts/screen_layout.dart';
import 'package:amazon/MyModels/order_request_model.dart';
import 'package:amazon/Mythemes/color_theme.dart';
import 'package:amazon/utilss/next_screen.dart';
import 'package:amazon/utilss/screen_size.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProductOrderScreen extends StatefulWidget {
  const ProductOrderScreen({super.key});

  @override
  State<ProductOrderScreen> createState() => _ProductOrderScreenState();
}

class _ProductOrderScreenState extends State<ProductOrderScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MyScreenSize().getScreenSize();

    // return SafeArea(
    //   child: Scaffold(
    //     body: SingleChildScrollView(
    //       child: Column(
    //         children: [
    //           Container(
    //             decoration: const BoxDecoration(
    //               gradient: LinearGradient(
    //                 colors:
    //                     backgroundGradient, // backgroundGradient taken from color_themes.dart
    //               ),
    //             ),
    //             // height: screenSize.height * 0.2,
    //             height: 40,
    //             width: screenSize.width,
    //             child: const Center(
    //               child: Text(
    //                 "Order Request from buyer",
    //                 style: TextStyle(
    //                     fontWeight: FontWeight.bold, color: Colors.black54),
    //               ),
    //             ),
    //           ),
    //           const SizedBox(
    //             height: 20,
    //           ),
    //           SizedBox(
    //             height: screenSize.height,
    //             width: screenSize.width,
    //             child: StreamBuilder(
    //               stream: FirebaseFirestore.instance
    //                   .collection("users")
    //                   .doc(FirebaseAuth.instance.currentUser!.uid)
    //                   .collection("orderRequest")
    //                   .snapshots(),
    //               builder: (context, snapshot) {
    //                 if (snapshot.connectionState == ConnectionState.waiting) {
    //                   return Container();
    //                 } else {
    //                   return ListView.builder(
    //                     itemCount: snapshot.data!.docs.length,
    //                     itemBuilder: (context, index) {
    //                       OrderRequestModel model =
    //                           OrderRequestModel.getModelFromJson(
    //                               snapshot.data!.docs[index].data());
    //                       return ListTile(
    //                         title: Text(
    //                           "Order: ${model.orderName}",
    //                           style:
    //                               const TextStyle(fontWeight: FontWeight.w500),
    //                         ),
    //                         subtitle: Text(
    //                             "Name: ${model.buyerName}\nAddress: ${model.buyerAddress}\nmobile: ${model.buyerMobile}"),
    //                         trailing: IconButton(
    //                           onPressed: () async {
    //                             FirebaseFirestore.instance
    //                                 .collection("users")
    //                                 .doc(FirebaseAuth.instance.currentUser!.uid)
    //                                 .collection("orderRequest")
    //                                 .doc(snapshot.data!.docs[index].id)
    //                                 .delete();
    //                           },
    //                           icon: const Icon(Icons.check),
    //                         ),
    //                       );
    //                     },
    //                   );
    //                 }
    //               },
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        leading: IconButton(
            onPressed: () {
              nextScreen(context, ScreenLayout());
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text("Order Requests"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(
              //     top: 10,
              //     left: 5,
              //     right: 2,
              //   ),
              //   child:
              SizedBox(
                height: screenSize.height,
                width: screenSize.width,
                // child:
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 24),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("orderRequest")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          OrderRequestModel model =
                              OrderRequestModel.getModelFromJson(
                                  snapshot.data!.docs[index].data());
                          return ListTile(
                            title: Text(
                              "Order : ${model.orderName}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            subtitle: Text(
                                "name: ${model.buyerName} , address: ${model.buyerAddress}\nmobile: ${model.buyerMobile}\npinCode: ${model.pinCode}"),
                            trailing: IconButton(
                              onPressed: () async {
                                FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .collection("orderRequest")
                                    .doc(snapshot.data!.docs[index].id)
                                    .delete();
                              },
                              icon: Icon(Icons.check),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
                // ),
              ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
