import 'package:amazon/MyModels/product_review_model.dart';
import 'package:amazon/Mythemes/contants.dart';
import 'package:amazon/utilss/screen_size.dart';
import 'package:amazon/widget/rating_star_widget.dart';
import 'package:flutter/material.dart';

class ReviewWidget extends StatefulWidget {
  final ProductReviewModel reviews;

  const ReviewWidget({super.key, required this.reviews});

  @override
  State<ReviewWidget> createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  Size screenSize = MyScreenSize().getScreenSize();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.reviews.senderName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                SizedBox(
                  width: screenSize.width / 3,
                  child: RatingStar(rating: widget.reviews.rating),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    keysRating[widget.reviews.rating - 1],
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40, top: 5),
            child: Text(
              widget.reviews.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
