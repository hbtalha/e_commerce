import 'package:e_commerce/models/rating.dart';
import 'package:flutter/material.dart';

void showSnackBar(
    {required String msg, required BuildContext context, bool isError = false, int seconds = 3}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        msg,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: isError ? const Color.fromARGB(255, 241, 75, 75) : Colors.black87,
      duration: Duration(seconds: seconds),
    ),
  );
}

void showBottomDialogPopup({
  required BuildContext context,
  required String title,
  double? height,
  EdgeInsetsGeometry padding = const EdgeInsets.only(left: 5, bottom: 10),
  required Widget item,
}) {
  height ??= MediaQuery.of(context).size.height * .4;

  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.grey[898],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      builder: (BuildContext bc) {
        return Container(
          padding: const EdgeInsets.only(left: 5, bottom: 10, right: 10),
          height: height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 19, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              item,
            ],
          ),
        );
      });
}

double getAvgRating(List<Rating> ratings) {
  double totalRating = 0;
  for (int i = 0; i < ratings.length; ++i) {
    totalRating += ratings[i].rating;
  }
  double avgRating = 0.0;
  if (totalRating != 0) {
    avgRating = totalRating / ratings.length;
  }

  return avgRating;
}
