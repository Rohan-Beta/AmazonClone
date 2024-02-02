// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:amazon/MyLayouts/screen_layout.dart';
import 'package:amazon/MyModels/order_request_model.dart';
import 'package:amazon/Mythemes/color_theme.dart';
import 'package:amazon/provider/sign_in_provider.dart';
import 'package:amazon/utilss/next_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductOrderScreen extends StatefulWidget {
  const ProductOrderScreen({super.key});

  @override
  State<ProductOrderScreen> createState() => _ProductOrderScreenState();
}

class _ProductOrderScreenState extends State<ProductOrderScreen> {
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
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("users")
                    .doc(sp.uid)
                    .collection("orderRequest")
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container();
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        OrderRequestModel model =
                            OrderRequestModel.getModelFromJson(
                                snapshot.data!.docs[index].data());
                        return ListTile(
                          title: Text(
                            "Order: ${model.orderName}",
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(
                              "Name: ${model.buyerName}\nAddress: ${model.buyerAddress}\nmobile: ${model.buyerMobile}\npinCode ${model.pinCode}"),
                          trailing: IconButton(
                            onPressed: () async {
                              FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(sp.uid)
                                  .collection("orderRequest")
                                  .doc(snapshot.data!.docs[index].id)
                                  .delete();
                            },
                            icon: const Icon(Icons.check),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
