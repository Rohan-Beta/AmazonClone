// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:typed_data';

import 'package:amazon/MyLayouts/screen_layout.dart';
import 'package:amazon/Mythemes/color_theme.dart';
import 'package:amazon/provider/sign_in_provider.dart';
import 'package:amazon/utilss/next_screen.dart';
import 'package:amazon/utilss/screen_size.dart';
import 'package:amazon/utilss/snack_bar.dart';
import 'package:amazon/utilss/text_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SellProductScreen extends StatefulWidget {
  const SellProductScreen({super.key});

  @override
  State<SellProductScreen> createState() => _SellProductScreenState();
}

class _SellProductScreenState extends State<SellProductScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool isLoading = false;
  int selected = 1;
  Uint8List? image;
  Uint8List? image1;
  Uint8List? image2;
  Uint8List? image3;

  List<int> discountKeys = [0, 70, 50, 30];

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    costController.dispose();
  }

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
    Size screenSize = MyScreenSize().getScreenSize();
    final sp = context.watch<SignInProvider>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Sell Product"),
        backgroundColor: backgroundColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black45,
          ),
          onPressed: () {
            nextScreenReplace(context, const ScreenLayout());
          },
        ),
      ),
      body: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 20),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // first image

                        image == null
                            ? SizedBox(
                                height: 70,
                                width: 70,
                                child: IconButton(
                                  icon: Icon(Icons.upload_outlined),
                                  onPressed: () async {
                                    Uint8List? temp =
                                        await MyScreenSize().pickImage();

                                    if (temp != null) {
                                      setState(() {
                                        image = temp;
                                      });
                                    }
                                  },
                                ),
                              )
                            : SizedBox(
                                height: 70,
                                width: 70,
                                child: Image.memory(image!),
                              ),

                        // second image
                        image1 == null
                            ? SizedBox(
                                height: 70,
                                width: 70,
                                child: IconButton(
                                  icon: Icon(Icons.upload_outlined),
                                  onPressed: () async {
                                    Uint8List? temp =
                                        await MyScreenSize().pickImage();

                                    if (temp != null) {
                                      setState(() {
                                        image1 = temp;
                                      });
                                    }
                                  },
                                ),
                              )
                            : SizedBox(
                                height: 70,
                                width: 70,
                                child: Image.memory(image1!),
                              ),

                        // third image
                        image2 == null
                            ? SizedBox(
                                height: 70,
                                width: 70,
                                child: IconButton(
                                  icon: Icon(Icons.upload_outlined),
                                  onPressed: () async {
                                    Uint8List? temp =
                                        await MyScreenSize().pickImage();

                                    if (temp != null) {
                                      setState(() {
                                        image2 = temp;
                                      });
                                    }
                                  },
                                ),
                              )
                            : SizedBox(
                                height: 70,
                                width: 70,
                                child: Image.memory(image2!),
                              ),

                        // fourth image
                        image3 == null
                            ? SizedBox(
                                height: 70,
                                width: 70,
                                child: IconButton(
                                  icon: Icon(Icons.upload_outlined),
                                  onPressed: () async {
                                    Uint8List? temp =
                                        await MyScreenSize().pickImage();

                                    if (temp != null) {
                                      setState(() {
                                        image3 = temp;
                                      });
                                    }
                                  },
                                ),
                              )
                            : SizedBox(
                                height: 70,
                                width: 70,
                                child: Image.memory(image3!),
                              ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: screenSize.height * 0.9,
                      width: screenSize.width * 0.9,
                      padding:
                          const EdgeInsets.only(top: 22, left: 10, right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // name
                          SignInTextForm(
                            myController: nameController,
                            myHintText: "Product Name",
                            myText: "cannot be empty",
                            myIcon: const Icon(Icons.sell_outlined),
                          ),

                          const SizedBox(
                            height: 15,
                          ),
                          // cost

                          SignInTextForm(
                            myController: costController,
                            myHintText: "Product Cost",
                            myText: "cannot be empty",
                            myIcon: const Icon(Icons.email),
                          ),

                          const SizedBox(
                            height: 15,
                          ),

                          // description
                          SignInTextForm(
                            myController: descriptionController,
                            myHintText: "Product Description",
                            myText: "cannot be empty",
                            myIcon: const Icon(Icons.description_outlined),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Discount",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            title: const Text("0%"),
                            leading: Radio(
                              value: 1,
                              groupValue: selected,
                              onChanged: (int? i) {
                                setState(() {
                                  selected = i!;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text("70%"),
                            leading: Radio(
                              value: 2,
                              groupValue: selected,
                              onChanged: (int? i) {
                                setState(() {
                                  selected = i!;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text("50%"),
                            leading: Radio(
                              value: 3,
                              groupValue: selected,
                              onChanged: (int? i) {
                                setState(() {
                                  selected = i!;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text("30%"),
                            leading: Radio(
                              value: 4,
                              groupValue: selected,
                              onChanged: (int? i) {
                                setState(() {
                                  selected = i!;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: 200,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.yellow),
                              child: const Text(
                                "Sell",
                                style: TextStyle(color: Colors.black),
                              ),
                              onPressed: () async {
                                String output = await sp.uploadProductInfo(
                                  image: image,
                                  productName: nameController.text,
                                  rawCost: costController.text,
                                  description: descriptionController.text,
                                  discount: discountKeys[selected - 1],
                                  sellerName: sp.name.toString(),
                                  sellerUid: sp.uid.toString(),
                                );

                                if (output == "success") {
                                  openSnackBar(
                                      context,
                                      "Product Uploaded Successfuly",
                                      Colors.yellow);
                                } else {
                                  openSnackBar(context, output, Colors.red);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
