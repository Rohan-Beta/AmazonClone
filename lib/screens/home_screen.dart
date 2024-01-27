import 'package:amazon/provider/sign_in_provider.dart';
import 'package:amazon/screens/login_screen.dart';
import 'package:amazon/utilss/next_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Welcome ${sp.name}",
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${sp.email}",
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${sp.uid}",
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Provider: ${sp.provider}".toUpperCase(),
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${sp.address}",
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
                child: const Text(
                  "Sign Out",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  sp.userSignOut();
                  nextScreenReplace(context, const LogInScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
