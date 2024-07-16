import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/constants/dimensions.dart';
import 'package:housekeeper/brain/constants/strings.dart';
import 'package:housekeeper/brain/data/models/keepers.dart';

class Testimony extends StatelessWidget {
  const Testimony({super.key, required this.houseKeeper});
  final KeeperModel houseKeeper;

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
                image: houseKeeper.user?.avatar == null
                    ? const DecorationImage(image: AssetImage(AppStrings.logoDark))
                    : DecorationImage(image: NetworkImage(houseKeeper.user!.avatar!)),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            Text(
              '${houseKeeper.user?.firstname} ${houseKeeper.user?.lastname}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const Text('Here is some bio about me !', style: TextStyle(fontSize: 12)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                for (int x = 0; x < 5; x++)
                  x < houseKeeper.rating!.floor()
                      ? const Icon(
                          Icons.star,
                          size: AppDimension.smallIcon,
                          color: Colors.yellow,
                        )
                      : x > houseKeeper.rating! - 1 && x < houseKeeper.rating!
                          ? const Icon(
                              Icons.star_half_sharp,
                              size: AppDimension.smallIcon,
                              color: Colors.yellow,
                            )
                          : const Icon(Icons.star_border_purple500_sharp, size: AppDimension.smallIcon),
                const SizedBox(width: 2),
                Text(
                  '(${houseKeeper.rating!.toPrecision(2)})',
                  style: const TextStyle(
                    fontSize: AppDimension.smallText,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
