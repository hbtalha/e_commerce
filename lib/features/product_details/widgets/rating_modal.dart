import 'package:e_commerce/common/widgets/custom_button.dart';
import 'package:e_commerce/common/widgets/custom_textfield.dart';
import 'package:e_commerce/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingModal extends StatefulWidget {
  final Function(String review, double rating) onPostReview;
  const RatingModal({Key? key, required this.onPostReview}) : super(key: key);

  @override
  State<RatingModal> createState() => _RatingModalState();
}

class _RatingModalState extends State<RatingModal> {
  TextEditingController textEditingController = TextEditingController();
  double rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RatingBar.builder(
            glow: false,
            initialRating: 1,
            minRating: 1,
            direction: Axis.horizontal,
            itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: GlobalVariables.secondaryColor,
                ),
            onRatingUpdate: (ratingValue) {
              rating = ratingValue;
            }),
        CustomTextField(
          controller: textEditingController,
          title: "Review (Optional)",
          maxLines: 7,
        ),
        const SizedBox(height: 10),
        CustomButton(
          height: 30,
          text: 'Post',
          onTap: () => widget.onPostReview(textEditingController.text, rating),
        )
      ],
    );
  }
}
