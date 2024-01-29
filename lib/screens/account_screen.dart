// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:amazon/Mythemes/color_theme.dart';
import 'package:amazon/provider/sign_in_provider.dart';
import 'package:amazon/utilss/screen_size.dart';
import 'package:amazon/widget/account_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
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
        child: Column(
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
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: "Hello"),
                      TextSpan(text: "${sp.name}"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
