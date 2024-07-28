import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/constants/dimensions.dart';
import 'package:housekeeper/brain/constants/strings.dart';
import 'package:housekeeper/brain/data/models/keepers.dart';
import 'package:housekeeper/brain/data/models/user.dart';
import 'package:housekeeper/brain/routes/names.dart';
import 'package:housekeeper/pages/components/rating_start.dart';

class Testimony extends StatelessWidget {
  const Testimony({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(AppRoutes.houseKeeperPage, arguments: {'user': user}),
      child: Card(
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
                  image: user.avatar == null
                      ? const DecorationImage(image: AssetImage(AppStrings.logoDark))
                      : DecorationImage(image: NetworkImage(user.avatar!)),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              Text(
                '${user.firstname} ${user.lastname}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Text(
                'Here is some bio about me !',
                style: TextStyle(fontSize: AppDimension.smallText),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              RatingStars(rating: user.keeper?.rating ?? 0),
            ],
          ),
        ),
      ),
    );
  }
}
