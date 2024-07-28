import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/constants/dimensions.dart';

class RatingStars extends StatelessWidget {
  const RatingStars({super.key, required this.rating});
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        for (int x = 0; x < 5; x++)
          x < rating.floor()
              ? const Icon(
                  Icons.star,
                  size: AppDimension.smallIcon,
                  color: Colors.yellow,
                )
              : x > rating - 1 && x < rating
                  ? const Icon(
                      Icons.star_half_sharp,
                      size: AppDimension.smallIcon,
                      color: Colors.yellow,
                    )
                  : const Icon(Icons.star_border_purple500_sharp, size: AppDimension.smallIcon),
        const SizedBox(width: 2),
        Text(
          '(${rating.toPrecision(2)})',
          style: const TextStyle(
            fontSize: AppDimension.smallText,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
