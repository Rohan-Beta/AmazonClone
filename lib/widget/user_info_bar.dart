import 'package:amazon/Mythemes/color_theme.dart';
import 'package:amazon/Mythemes/contants.dart';
import 'package:amazon/provider/sign_in_provider.dart';
import 'package:amazon/utilss/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserInfoBar extends StatefulWidget {
  final double offset;

  const UserInfoBar({super.key, required this.offset});

  @override
  State<UserInfoBar> createState() => _UserInfoBarState();
}

class _UserInfoBarState extends State<UserInfoBar> {
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
    // get info of user from data base

    return Positioned(
      top: -widget.offset / 3,
      child: Container(
        height: kAppBarHeight / 2,
        width: screenSize.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: lightBackgroundaGradient,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 3,
            horizontal: 10,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.location_on_outlined,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(
                width: screenSize.width * 0.7,
                child: Text(
                  "${sp.address}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
