// ignore_for_file: await_only_futures, avoid_print, unnecessary_import, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInProvider extends ChangeNotifier {
  // instance for FirebaseAuth

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // sign in or not

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  // has error , error code , provider , Uid , email , name , imageUrl

  bool _hasError = false;
  bool get hasError => _hasError;

  String? _errorCode;
  String? get errorCode => _errorCode;

  String? _provider;
  String? get provider => _provider;

  String? _uid;
  String? get uid => _uid;

  String? _name;
  String? get name => _name;

  String? _email;
  String? get email => _email;

  String? _imageUrl;
  String? get imageUrl => _imageUrl;

  SignInProvider() {
    checkSignInUser();
  }

  Future checkSignInUser() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("signed_in") ?? false;
    notifyListeners();
  }

  // user successfully sign in

  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("signed_in", true);
    _isSignedIn = true;
    notifyListeners();
  }

  // entry for CloudFirestore
  // if the user already exists

  Future getUserDataFromFireStore(uid) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get()
        .then((DocumentSnapshot snapshot) => {
              _uid = snapshot["uid"],
              _name = snapshot["name"],
              _email = snapshot["email"],
              _imageUrl = snapshot["imageUrl"],
              _provider = snapshot["provoder"],
            });
  }

  // entry for CloudFirestore
  // if the user does not exists

  Future saveDataToFireStore() async {
    final DocumentReference reference =
        FirebaseFirestore.instance.collection("users").doc(uid);

    await reference.set({
      "uid": _uid,
      "name": _name,
      "email": _email,
      "imageUrl": _imageUrl,
      "privider": _provider,
    });
    notifyListeners();
  }

  // Save Data To Shared Preferences

  Future saveDataToSharedPreferences() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString("uid", _uid!);
    await s.setString("name", _name!);
    await s.setString("email", _email!);
    await s.setString("imageUrl", _imageUrl!);
    await s.setString("provider", _provider!);

    notifyListeners();
  }

  // get data from Shared Preferences

  Future getDataFromSharedPreferences() async {
    final SharedPreferences s = await SharedPreferences.getInstance();

    _uid = s.getString("uid");
    _name = s.getString("name");
    _email = s.getString("email");
    _imageUrl = s.getString("imageUrl");
    _provider = s.getString("provider");

    notifyListeners();
  }

  // check user exists or not in CloudFirestore

  Future<bool> checkUserExists() async {
    DocumentSnapshot snap =
        await FirebaseFirestore.instance.collection("user").doc(_uid).get();

    if (snap.exists) {
      print("User Exists");
      return true;
    } else {
      print("New User");
      return false;
    }
  }

  // sign out

  Future userSignOut() async {
    await firebaseAuth.signOut;

    _isSignedIn = false;
    notifyListeners();

    // clear all data of the user
    clearStorageData();
  }

// clear all data of the user

  Future clearStorageData() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.clear();
  }

  void phoneNumberUser(User user, email, name) {
    _name = name;
    _email = email;
    _imageUrl =
        const Image(image: AssetImage("MyAssets/splashimage.png")).toString();
    _uid = user.phoneNumber;
    _provider = "PHONE";
    notifyListeners();
  }
}
