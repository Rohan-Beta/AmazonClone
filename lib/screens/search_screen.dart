// ignore_for_file: prefer_const_constructors

import 'package:amazon/widget/search_bar.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          appBar: MySearchBar(isReadOnly: false, hasBackButtom: true),
          body: Text("Search Screen"),
        ),
      ),
    );
  }
}
