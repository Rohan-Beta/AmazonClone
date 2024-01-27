// ignore_for_file: file_names

import 'package:amazon/Mythemes/color_theme.dart';
import 'package:amazon/provider/internet_provider.dart';
import 'package:amazon/provider/sign_in_provider.dart';
import 'package:amazon/screens/home_screen.dart';
import 'package:amazon/screens/login_screen.dart';
import 'package:amazon/utilss/next_screen.dart';
import 'package:amazon/utilss/screen_size.dart';
import 'package:amazon/utilss/snack_bar.dart';
import 'package:amazon/utilss/text_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController otpCodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MyScreenSize().getScreenSize();

    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Amazon Clone"),
            backgroundColor: backgroundColor,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black45,
              ),
              onPressed: () {
                nextScreenReplace(context, const LogInScreen());
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(
                          image: AssetImage("MyAssets/registerimage.png"),
                          height: 70,
                          width: 70,
                        ),
                        Image(
                          image: AssetImage("MyAssets/register2.png"),
                          height: 70,
                          width: 70,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Center(
                      child: Text(
                        "User SignIn",
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Container(
                      height: screenSize.height * 0.5,
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
                        children: [
                          // user name
                          SignInTextForm(
                            myController: nameController,
                            myHintText: "User Name",
                            myText: "Name cannot be empty",
                            myIcon: const Icon(Icons.account_circle),
                          ),

                          const SizedBox(
                            height: 15,
                          ),
                          // email
                          SignInTextForm(
                            myController: emailController,
                            myHintText: "Yours@gmail.com",
                            myText: "Email cannot be empty",
                            myIcon: const Icon(Icons.email),
                          ),

                          const SizedBox(
                            height: 15,
                          ),

                          // phone
                          SignInTextForm(
                            myController: phoneController,
                            myHintText: "+0-1234567890",
                            myText: "Phone number cannot be empty",
                            myIcon: const Icon(Icons.phone),
                          ),
                          const SizedBox(
                            height: 25,
                          ),

                          // address
                          SignInTextForm(
                            myController: addressController,
                            myHintText: "enter your address",
                            myText: "address cannot be empty",
                            myIcon: const Icon(Icons.location_on),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow),
                      child: const Text(
                        "Sign In",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        login(context, phoneController.text.trim());
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "New To Amazon",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                      ],
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

  Future login(BuildContext context, String mobile) async {
    final sp = context.read<SignInProvider>();
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    if (ip.hasInternet == false) {
      // ignore: use_build_context_synchronously
      openSnackBar(context, "Check your internet connection", Colors.red);
    } else {
      if (formKey.currentState!.validate()) {
        FirebaseAuth.instance.verifyPhoneNumber(
            phoneNumber: mobile,
            verificationCompleted: (AuthCredential credential) async {
              await FirebaseAuth.instance.signInWithCredential(credential);
            },
            verificationFailed: (FirebaseAuthException e) {
              openSnackBar(context, e.toString(), Colors.red);
            },
            codeSent: (String verificationId, int? forceResendingToken) {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Enter Code"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: otpCodeController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.code),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Colors.blue),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            child: const Text("Confirm"),
                            onPressed: () async {
                              final code = otpCodeController.text.trim();
                              AuthCredential authCredential =
                                  PhoneAuthProvider.credential(
                                      verificationId: verificationId,
                                      smsCode: code);
                              User user = (await FirebaseAuth.instance
                                      .signInWithCredential(authCredential))
                                  .user!;

                              // save the details
                              sp.phoneNumberUser(
                                user,
                                emailController.text,
                                nameController.text,
                                addressController.text,
                              );

                              // check user exists or not
                              sp.checkUserExists().then((value) async {
                                if (value == true) {
                                  // user exists

                                  await sp
                                      .getUserDataFromFireStore(sp.uid)
                                      .then((value) => sp
                                          .saveDataToSharedPreferences()
                                          .then((value) =>
                                              sp.setSignIn().then((value) {
                                                nextScreenReplace(context,
                                                    const HomeScreen());
                                              })));
                                } else {
                                  // user does not exists

                                  sp.saveDataToFireStore().then((value) => sp
                                      .saveDataToSharedPreferences()
                                      .then((value) =>
                                          sp.setSignIn().then((value) {
                                            nextScreenReplace(
                                                context, const HomeScreen());
                                          })));
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  });
            },
            codeAutoRetrievalTimeout: (String verification) {});
      }
    }
  }
}
