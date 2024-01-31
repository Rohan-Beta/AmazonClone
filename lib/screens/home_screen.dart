// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:amazon/Mythemes/color_theme.dart';
import 'package:amazon/provider/sign_in_provider.dart';
import 'package:amazon/utilss/screen_size.dart';
import 'package:amazon/widget/banner_add.dart';
import 'package:amazon/widget/horizontal_catalog_view.dart';
import 'package:amazon/widget/product_view.dart';
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
    getDiscountData();
  }

  List<Widget>? discount0;
  List<Widget>? discount70;
  List<Widget>? discount50;
  List<Widget>? discount30;

  void getDiscountData() async {
    List<Widget> temp0 = await SignInProvider().getProductDiscount(0);
    List<Widget> temp70 = await SignInProvider().getProductDiscount(70);
    List<Widget> temp50 = await SignInProvider().getProductDiscount(50);
    List<Widget> temp30 = await SignInProvider().getProductDiscount(30);

    setState(() {
      discount0 = temp0;
      discount70 = temp70;
      discount50 = temp50;
      discount30 = temp30;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();
    Size screenSize = MyScreenSize().getScreenSize();

    return Scaffold(
      appBar: MySearchBar(isReadOnly: true, hasBackButtom: false),
      body: discount70 != null &&
              discount50 != null &&
              discount30 != null &&
              discount0 != null
          ? SafeArea(
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
                      children: discount70!,
                    ),
                    ProductsView(
                      title: "Upto 50% off",
                      children: discount50!,
                    ),
                    ProductsView(
                      title: "Upto 30% off",
                      children: discount30!,
                    ),
                    ProductsView(
                      title: "Explore",
                      children: discount0!,
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(color: Colors.blue[300]),
            ),
    );
  }
}
