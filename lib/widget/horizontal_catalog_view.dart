import 'package:amazon/Mythemes/contants.dart';
import 'package:amazon/screens/result_screen.dart';
import 'package:flutter/material.dart';

class HorizontalCatalogView extends StatelessWidget {
  const HorizontalCatalogView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kAppBarHeight, // kAppBarHeigh taken from constant.dart
      width: double.infinity,
      color: Colors.white,
      // categoriesList and categoryLogos taken from constants.dart
      child: ListView.builder(
        itemCount: categoriesList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultScreen(
                    query: categoriesList[index],
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        categoryLogos[index],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        categoriesList[index],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
