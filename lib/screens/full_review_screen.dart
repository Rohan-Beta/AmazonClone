// ignore_for_file: prefer_const_constructors

import 'package:amazon/MyLayouts/screen_layout.dart';
import 'package:amazon/MyModels/product_model.dart';
import 'package:amazon/MyModels/product_review_model.dart';
import 'package:amazon/utilss/next_screen.dart';
import 'package:amazon/utilss/screen_size.dart';
import 'package:amazon/widget/review_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FullReviewScreen extends StatefulWidget {
  final ProductModel productModel;

  const FullReviewScreen({super.key, required this.productModel});

  @override
  State<FullReviewScreen> createState() => _FullReviewScreenState();
}

class _FullReviewScreenState extends State<FullReviewScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MyScreenSize().getScreenSize();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent,
        title: Text("Review Screen"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            height: screenSize.height,
            child:
                // Padding(
                //   padding: const EdgeInsets.only(left: 20, bottom: 75),
                //   child: ListView.builder(
                //     itemCount: 10,
                //     itemBuilder: (context, index) {
                //       return ReviewWidget(
                //         reviews: ProductReviewModel(
                //             senderName: "Rohit", description: "Godd", rating: 4),
                //       );
                //     },
                //   ),
                // ),
                Padding(
              padding: const EdgeInsets.only(left: 25),
              child: SizedBox(
                height: screenSize.height,
                width: screenSize.width,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("products")
                      .doc(widget.productModel.uid)
                      .collection("reviews")
                      .snapshots(),
                  builder: (context, snapshot) {
                    // ProductReviewModel models;
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          ProductReviewModel model =
                              ProductReviewModel.getModelFromJson(
                                  snapshot.data!.docs[index].data());
                          return ReviewWidget(reviews: model);
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      )),
    );

    // return SafeArea(
    //   child: Scaffold(
    //     body: SingleChildScrollView(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.only(left: 25),
    //             child: SizedBox(
    //               height: screenSize.height,
    //               width: screenSize.width,
    //               child: StreamBuilder(
    //                 stream: FirebaseFirestore.instance
    //                     .collection("products")
    //                     .doc(widget.product.uid)
    //                     .collection("reviews")
    //                     .snapshots(),
    //                 builder: (context, snapshot) {
    //                   // ProductReviewModel models;
    //                   if (snapshot.connectionState == ConnectionState.waiting) {
    //                     return Container();
    //                   } else {
    //                     return ListView.builder(
    //                       itemCount: snapshot.data!.docs.length,
    //                       itemBuilder: (context, index) {
    //                         ProductReviewModel model =
    //                             ProductReviewModel.getModelFromJson(
    //                                 snapshot.data!.docs[index].data());
    //                         return MyReview(reviews: model);
    //                       },
    //                     );
    //                   }
    //                   // return MyReview(reviews: models)
    //                 },
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
