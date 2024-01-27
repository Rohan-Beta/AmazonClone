import 'package:amazon/screens/phoneAuth_screen.dart';
import 'package:amazon/utilss/next_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:amazon/utilss/screen_size.dart';
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
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: const AssetImage("MyAssets/login.png"),
                      height: 80,
                      width: screenSize.width * 0.60,
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 20, left: 40, right: 40, top: 30),

                    // phone

                    child: RoundedLoadingButton(
                      controller: phoneController,
                      successColor: Colors.yellow,
                      color: Colors.yellow,
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
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Sign in with phone",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
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
