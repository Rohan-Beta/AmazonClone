import 'package:amazon/screens/phoneAuth_screen.dart';
import 'package:amazon/utilss/next_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:amazon/utilss/screen_size.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  RoundedLoadingButtonController phoneController =
      RoundedLoadingButtonController();

  Size screenSize = MyScreenSize().getScreenSize();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: NetworkImage(
                          "https://miro.medium.com/v2/resize:fit:500/1*Q7TzUZZ9bOZO7rQsbc6IGg.png"),
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),

              // phone
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 20, left: 40, right: 40, top: 30),
                    child: RoundedLoadingButton(
                      controller: phoneController,
                      successColor: Colors.black,
                      color: Colors.black,
                      width: screenSize.width * 0.80,
                      onPressed: () {
                        nextScreen(context, const PhoneAuthScreen());
                        phoneController.reset();
                      },
                      child: const Wrap(
                        children: [
                          Icon(
                            FontAwesomeIcons.phone,
                            size: 20,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Sign in with phone",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
