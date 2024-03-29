import 'package:amazon/MyModels/product_review_model.dart';
import 'package:amazon/Mythemes/contants.dart';
import 'package:amazon/provider/sign_in_provider.dart';
import 'package:amazon/utilss/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';

class ReviewDialog extends StatefulWidget {
  final String productUid;

  const ReviewDialog({super.key, required this.productUid});

  @override
  State<ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Size screenSize = MyScreenSize().getScreenSize();

  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();

    return RatingDialog(
      // your app's name?

      title: const Text(
        'Amazon Clone',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),

      // encourage your user to leave a high rating?
      message: const Text(
        "Type a review and give stars to set your rating",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
      // your app's logo?

      // image: const FlutterLogo(size: 100),
      image: Image.network(
        amazonLogoUrl,
        width: screenSize.width / 8,
        height: screenSize.height / 6,
      ),

      submitButtonText: 'Send',
      commentHint: 'Type here',

      // onCancelled: () => print('cancelled'),

      onSubmitted: (RatingDialogResponse response) {
        sp.uploadReviewInfo(
          productUid: widget.productUid,
          reviewModel: ProductReviewModel(
            senderName: sp.name!,
            description: response.comment,
            rating: response.rating.toInt(),
          ),
        );
        // MyFireStore().uploadReviewInfo(
        //   productUid: productUid,
        //   reviewModel: ProductReviewModel(
        //     senderName: Provider.of<UserDetailsProvider>(context, listen: false)
        //         .userDetails
        //         .name,
        //     description: response.comment,
        //     rating: response.rating.toInt(),
        //   ),
        // );
      },
    );
  }
}
