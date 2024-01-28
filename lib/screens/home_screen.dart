// ignore_for_file: prefer_const_constructors

import 'package:amazon/Mythemes/color_theme.dart';
import 'package:amazon/provider/sign_in_provider.dart';
import 'package:amazon/utilss/screen_size.dart';
import 'package:amazon/widget/banner_add.dart';
import 'package:amazon/widget/horizontal_catalog_view.dart';
import 'package:amazon/widget/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                      child: Icon(Icons.location_history_outlined),
                    ),
                    Text("${sp.address}"),
                  ],
                ),
              ),
              SizedBox(
                height: 90,
                child: HorizontalCatalogView(),
              ),
              BannerAdd(),
            ],
          ),
        ),
      ),
    );
  }
}
