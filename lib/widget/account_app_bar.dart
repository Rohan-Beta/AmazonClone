// ignore_for_file: prefer_const_constructors

import 'package:amazon/Mythemes/color_theme.dart';
import 'package:amazon/Mythemes/contants.dart';
import 'package:amazon/utilss/screen_size.dart';
import 'package:flutter/material.dart';

class AccountAppBar extends StatefulWidget implements PreferredSizeWidget {
  const AccountAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kAppBarHeight);

  @override
  State<AccountAppBar> createState() => _AccountAppBarState();
}

class _AccountAppBarState extends State<AccountAppBar> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MyScreenSize().getScreenSize();

    return Container(
      height: kAppBarHeight,
      width: screenSize.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: backgroundGradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Image.network(
              amazonLogoUrl, // a logo in app bar
              height: kAppBarHeight * 0.7,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              children: [
                // some icons in app bar

                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications_outlined,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const MySearchScreen()),
                    // );
                  },
                  icon: const Icon(
                    Icons.search_outlined,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
