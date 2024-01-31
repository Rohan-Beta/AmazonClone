// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:amazon/MyModels/product_model.dart';
import 'package:amazon/Mythemes/color_theme.dart';
import 'package:amazon/provider/sign_in_provider.dart';
import 'package:amazon/utilss/screen_size.dart';
import 'package:amazon/widget/banner_add.dart';
import 'package:amazon/widget/horizontal_catalog_view.dart';
import 'package:amazon/widget/product_view.dart';
import 'package:amazon/widget/sample_product.dart';
import 'package:amazon/widget/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      appBar: MySearchBar(isReadOnly: true, hasBackButtom: false),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: backgroundGradient,
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                  ),
                ),
                width: screenSize.width,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 10, bottom: 4, top: 4),
                      child: Icon(Icons.location_history_outlined),
                    ),
                    Text(
                      "${sp.address}  -  ${sp.pincode}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
                child: HorizontalCatalogView(),
              ),
              BannerAdd(),
              SizedBox(
                height: 20,
              ),
              ProductsView(
                title: "Upto 70% off",
                children: [
                  SampleProduct(
                    productModel: ProductModel(
                      "https://m.media-amazon.com/images/I/51QISbJp5-L._SX3000_.jpg",
                      "Iphone",
                      100,
                      10,
                      "123456789",
                      "Rohan",
                      "8017202787",
                      4,
                    ),
                  ),
                ],
              ),
              ProductsView(title: "Upto 50% off", children: []),
              ProductsView(title: "Upto 30% off", children: []),
              ProductsView(title: "Explore", children: []),
            ],
          ),
        ),
      ),
    );
  }
}
