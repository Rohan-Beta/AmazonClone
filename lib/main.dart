import 'package:amazon/provider/internet_provider.dart';
import 'package:amazon/provider/sign_in_provider.dart';
import 'package:amazon/screens/home_screen.dart';
import 'package:amazon/screens/login_screen.dart';
import 'package:amazon/screens/phoneAuth_screen.dart';
import 'package:amazon/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCPKT7FtUBTszbepHhm046s8SFXG2UJmyk",
          authDomain: "clone-a1a2e.firebaseapp.com",
          projectId: "clone-a1a2e",
          storageBucket: "clone-a1a2e.appspot.com",
          messagingSenderId: "644371332922",
          appId: "1:644371332922:web:49e99d3ca1a120cc62da03",
          measurementId: "G-1KP9F0MC7C"),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const AmazonClone());
}

class AmazonClone extends StatelessWidget {
  const AmazonClone({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignInProvider()),
        ChangeNotifierProvider(create: (context) => InternetProvider()),
      ],
      child: const MaterialApp(
        title: "Amazon Clone",
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SafeArea(
            child: MySplashScreen(),
          ),
        ),
      ),
    );
  }
}
