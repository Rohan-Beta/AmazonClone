// ignore_for_file: prefer_const_constructors

import 'package:amazon/MyLayouts/screen_layout.dart';
import 'package:amazon/Mythemes/color_theme.dart';
import 'package:amazon/Mythemes/contants.dart';
import 'package:amazon/screens/home_screen.dart';
import 'package:amazon/screens/search_screen.dart';
import 'package:amazon/utilss/next_screen.dart';
import 'package:amazon/utilss/screen_size.dart';
import 'package:flutter/material.dart';

class MySearchBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isReadOnly;
  final bool hasBackButtom;

  const MySearchBar(
      {super.key, required this.isReadOnly, required this.hasBackButtom});

  @override
  Size get preferredSize => const Size.fromHeight(kAppBarHeight);

  @override
  Widget build(BuildContext context) {
    Size screenSise = MyScreenSize().getScreenSize();
    return Container(
      height: kAppBarHeight,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors:
              backgroundGradient, // backgroundGradient taken from color_themes.dart

          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          hasBackButtom
              ? IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    nextScreen(context, ScreenLayout());
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                )
              : Container(),
          SizedBox(
            width: screenSise.width * 0.7,
            height: 50,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    spreadRadius: 1,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: TextField(
                onSubmitted: (String query) {
                  print("search ${query}");
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => MyResultScreen(query: query),
                  //   ),
                  // );
                },
                readOnly: isReadOnly,
                onTap: () {
                  if (isReadOnly) {
                    nextScreen(context, SearchScreen());
                  }
                },
                decoration: InputDecoration(
                  hintText: "Looking for something? Search here",
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: const BorderSide(width: 1, color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide:
                        const BorderSide(width: 1, color: Colors.indigo),
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.mic_off_outlined),
          ),
        ],
      ),
    );
  }
}
