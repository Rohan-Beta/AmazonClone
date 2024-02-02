// ignore_for_file: await_only_futures, avoid_print, unnecessary_import, prefer_final_fields, division_optimization

import 'package:amazon/MyModels/order_request_model.dart';
import 'package:amazon/MyModels/product_model.dart';
import 'package:amazon/MyModels/product_review_model.dart';
import 'package:amazon/MyModels/user_info_model.dart';
import 'package:amazon/utilss/screen_size.dart';
import 'package:amazon/widget/sample_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInProvider extends ChangeNotifier {
  // instance for FirebaseAuth

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

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

  String? _address;
  String? get address => _address;

  String? _pincode;
  String? get pincode => _pincode;

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
              _provider = snapshot["provider"],
              _address = snapshot["address"],
              _pincode = snapshot["pincode"],
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
      "provider": _provider,
      "address": _address,
      "pincode": _pincode,
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
    await s.setString("address", _address!);
    await s.setString("pincode", _pincode!);

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
    _address = s.getString("address");
    _pincode = s.getString("pincode");

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

// get details of user at the time of SignIn

  void phoneNumberUser(User user, email, name, address, pincode) {
    _name = name;
    _email = email;
    _imageUrl =
        const Image(image: AssetImage("MyAssets/splashimage.png")).toString();

    _uid = user.phoneNumber;
    _provider = "PHONE";
    _address = address;
    _pincode = pincode;
    notifyListeners();
  }

  // upload product name and cost to database

  Future<String> uploadProductInfo({
    required Uint8List? image,
    required String productName,
    required String
        rawCost, // cost = rawcost - (rawcost * 0.5) for 50% discount
    required String description,
    required int discount,
    required String sellerName,
    required String sellerUid,
  }) async {
    productName.trim();
    rawCost.trim();
    String output = "Something went wrong";

    if (image != null && productName != "" && rawCost != "") {
      // function

      try {
        String url = await uploadProductImage(
          image: image,
          uid: _uid!,
        );
        double cost = double.parse(rawCost);
        cost = cost - (cost * (discount / 100));

        String uid = MyScreenSize().getUid();

        ProductModel product = ProductModel(
          url,
          productName,
          cost,
          discount,
          uid,
          sellerName,
          sellerUid,
          5,
          description,
        );
        await firebaseFirestore
            .collection("products")
            .doc(uid)
            .set(product.getJson());

        output = "success";
      } catch (e) {
        output = e.toString();
      }
    } else {
      output = "Please fill up everything properly";
    }
    return output;
  }
  // upload product image to database

  Future<String> uploadProductImage(
      {required Uint8List image, required String uid}) async {
    Reference storageRef = FirebaseStorage.instance // store images in folder
        .ref()
        .child("products") // storage or folder name
        .child(uid);

    UploadTask uploadTask = storageRef.putData(image);
    TaskSnapshot taskSnap = await uploadTask;

    return taskSnap.ref
        .getDownloadURL(); // basically it download image url from database
  }

  // take snap of product info with respect to their discount

  Future<List<Widget>> getProductDiscount(num discount) async {
    List<Widget> children = [];

    QuerySnapshot<Map<String, dynamic>> snap = await firebaseFirestore
        .collection("products")
        .where("discount", isEqualTo: discount)
        .get();

    for (int i = 0; i < snap.docs.length; i += 1) {
      DocumentSnapshot docSnap = snap.docs[i];
      ProductModel model =
          ProductModel.getModelFromJson(docSnap.data() as dynamic);
      children.add(
        SampleProduct(productModel: model),
      );
    }
    return children;
  }

  // upload reviews to database

  Future uploadReviewInfo(
      {required productUid, required ProductReviewModel reviewModel}) async {
    await firebaseFirestore
        .collection("products")
        .doc(productUid)
        .collection("reviews")
        .add(reviewModel.getJson());
    await averageRating(productUid: productUid, reviewModel: reviewModel);
  }
  // get the average rating of product

  Future averageRating(
      {required String productUid,
      required ProductReviewModel reviewModel}) async {
    DocumentSnapshot snapshot =
        await firebaseFirestore.collection("products").doc(productUid).get();

    ProductModel model =
        ProductModel.getModelFromJson((snapshot.data() as dynamic));

    int currentRating = model.rating;
    int newRating = ((currentRating + reviewModel.rating) / 2).toInt();

    await firebaseFirestore
        .collection("products")
        .doc(productUid)
        .update({"rating": newRating});
  }

  // add cart product

  Future addProductToCart({required ProductModel productModel}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("cart")
        .doc(productModel.uid)
        .set(productModel.getJson());
  }

  // delete product from cart

  Future deleteCartProduct({required String uid}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("cart")
        .doc(uid)
        .delete();
  }

  // buy products from cart or from main screen

  Future buyAllProductsInCarts({required UserInfoModel userInfo}) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("cart")
        .get();

    for (int i = 0; i < snapshot.docs.length; i += 1) {
      ProductModel model =
          ProductModel.getModelFromJson(snapshot.docs[i].data());

      addProductToOrder(model: model, userInfo: userInfo);
      await deleteCartProduct(uid: model.uid);
    }
  }

  // add product to order in account section
  // purchase the order or product

  Future addProductToOrder({
    required ProductModel model,
    required UserInfoModel userInfo,
  }) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("orders")
        .add(model.getJson());
    await getOrderRequest(model: model, userInfo: userInfo
        // name: _name!,
        // address: _address!,
        // mobile: _uid!,
        // pincode: _pincode!,
        );
  }
  // get order request from buyer

  Future getOrderRequest({
    required ProductModel model,
    required UserInfoModel userInfo,
    // required String name,
    // required String address,
    // required String mobile,
    // required String pincode,
  }) async {
    OrderRequestModel orderRequestModel = OrderRequestModel(
      model.productName,
      userInfo.address,
      userInfo.uid,
      userInfo.name,
      userInfo.pincode,
      // name,
      // address,
      // mobile,
      // pincode,
    );
    await firebaseFirestore
        .collection("users")
        .doc(model.sellerUid)
        .collection("orderRequest")
        .add(orderRequestModel.getJson());
  }
}
