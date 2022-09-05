import 'package:e_commerce/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:e_commerce/models/rating.dart';

class CommentCard extends StatelessWidget {
  final Rating rating;
  CommentCard({
    Key? key,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Username - Rating - Comments
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Username - Rating
                Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 8,
                        child: Text(
                          rating.userName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0A0E2F),
                            fontFamily: 'poppins',
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Flexible(
                        flex: 4,
                        child: RatingBarIndicator(
                          direction: Axis.horizontal,
                          itemCount: 5,
                          rating: rating.rating,
                          itemSize: 12,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: GlobalVariables.secondaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // Comments
                Text(
                  rating.comment,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    height: 150 / 100,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
