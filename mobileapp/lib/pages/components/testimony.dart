import 'package:flutter/material.dart';
import 'package:housekeeper/brain/constants/dimensions.dart';
import 'package:housekeeper/brain/constants/strings.dart';

class Testimony extends StatelessWidget {
  const Testimony({super.key, this.image, required this.name, required this.text, required this.ratings});
  final String? image;
  final String name;
  final String text;
  final double ratings;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        width: 160,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                image: image == null
                    ? const DecorationImage(image: AssetImage(AppStrings.logoDark))
                    : DecorationImage(image: NetworkImage(image!)),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text(text, style: const TextStyle(fontSize: 12)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                for (int x = 0; x < 5; x++) const Icon(Icons.star_border_purple500_sharp, size: AppDimension.smallIcon)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
