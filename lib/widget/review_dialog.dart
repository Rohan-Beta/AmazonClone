import 'package:amazon/Mythemes/contants.dart';
import 'package:amazon/utilss/screen_size.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';

class ReviewDialog extends StatefulWidget {
  const ReviewDialog({super.key});

  @override
  State<ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  Size screenSize = MyScreenSize().getScreenSize();

  @override
  Widget build(BuildContext context) {
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
