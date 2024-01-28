// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:amazon/Mythemes/color_theme.dart';
import 'package:amazon/screens/account_screen.dart';
import 'package:amazon/screens/cart_screen.dart';
import 'package:amazon/screens/home_screen.dart';
import 'package:amazon/screens/more_screen.dart';
import 'package:flutter/material.dart';

class ScreenLayout extends StatefulWidget {
  const ScreenLayout({super.key});

  @override
  State<ScreenLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout> {
  PageController pageController = PageController();
  int currentPage = 0;

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  changePage(int page) {
    pageController.jumpToPage(page);
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 4,
          child: Scaffold(
            body: PageView(
              controller: pageController,
              children: [
                HomeScreen(),
                AccountScreen(),
                CartScreen(),
                MoreScreen(),
              ],
            ),
            bottomNavigationBar: Container(
              // decoration: BoxDecoration(
              //   border: Border(
              //     top: BorderSide(color: Colors.grey[400]!, width: 1),
              //   ),
              // ),
              child: TabBar(
                indicator: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: activeCyanColor, width: 2),
                  ),
                ),
                indicatorColor: activeCyanColor,
                onTap: changePage,
                tabs: [
                  Tab(
                    child: Icon(
                      Icons.home_outlined,
                      color: currentPage == 0 ? activeCyanColor : Colors.black,
                    ),
                  ),
                  Tab(
                    child: Icon(
                      Icons.account_circle_outlined,
                      color: currentPage == 1 ? activeCyanColor : Colors.black,
                    ),
                  ),
                  Tab(
                    child: Icon(
                      Icons.card_travel,
                      color: currentPage == 2 ? activeCyanColor : Colors.black,
                    ),
                  ),
                  Tab(
                    child: Icon(
                      Icons.more_horiz_outlined,
                      color: currentPage == 3 ? activeCyanColor : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
