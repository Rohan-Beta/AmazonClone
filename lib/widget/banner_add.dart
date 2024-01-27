import 'package:amazon/Mythemes/color_theme.dart';
import 'package:amazon/Mythemes/contants.dart';
import 'package:amazon/utilss/screen_size.dart';
import 'package:flutter/material.dart';

class BannerAdd extends StatefulWidget {
  const BannerAdd({super.key});

  @override
  State<BannerAdd> createState() => _BannerAddState();
}

class _BannerAddState extends State<BannerAdd> {
  int currAdd = 0;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MyScreenSize().getScreenSize();
    double smallAddHeight = screenSize.width / 5;

    return GestureDetector(
      // largeAds and smallAds taken from constants.dart
      onHorizontalDragEnd: (_) {
        if (currAdd == largeAds.length - 1) {
          currAdd = -1;
        }
        setState(() {
          currAdd++;
        });
      },
      child: Column(
        children: [
          // for large adds

          Stack(
            children: [
              Image.network(
                largeAds[currAdd],
                width: double.infinity,
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: screenSize.width,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        backgroundColor,
                        backgroundColor.withOpacity(0),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // for small adds

          Container(
            color: backgroundColor,
            width: screenSize.width,
            height: smallAddHeight, //smallAddHeight,
            child:
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     smallAddFromIndex(0, smallAddHeight),
                //     smallAddFromIndex(1, smallAddHeight),
                //     smallAddFromIndex(2, smallAddHeight),
                //     smallAddFromIndex(3, smallAddHeight),
                //   ],
                // )

                // shows small add in list view format

                ListView.builder(
              itemCount: smallAds.length - 3,
              scrollDirection: Axis.horizontal,
              itemBuilder: (index, height) {
                return GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(width: 15),
                      smallAddFromIndex(0, smallAddHeight),
                      const SizedBox(width: 15),
                      smallAddFromIndex(1, smallAddHeight),
                      const SizedBox(width: 15),
                      smallAddFromIndex(2, smallAddHeight),
                      const SizedBox(width: 15),
                      smallAddFromIndex(3, smallAddHeight),
                      const SizedBox(width: 15),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
// small ads style fixing

Widget smallAddFromIndex(int index, double height) {
  return Container(
    height: height,
    width: height,
    decoration: ShapeDecoration(
      color: Colors.white,
      shadows: [
        BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 1),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(smallAds[index]),
          // const SizedBox(height: 10),
          Text(adItemNames[index]),
        ],
      ),
    ),
  );
}
