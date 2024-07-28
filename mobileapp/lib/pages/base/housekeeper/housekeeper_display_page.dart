import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/constants/dimensions.dart';
import 'package:housekeeper/brain/constants/strings.dart';
import 'package:housekeeper/brain/controllers/house_keeper_page_controller.dart';
import 'package:housekeeper/brain/helpers/utilities.dart';
import 'package:housekeeper/pages/components/animate_text.dart';
import 'package:housekeeper/pages/components/my_button.dart';
import 'package:housekeeper/pages/components/rating_start.dart';

class HousekeeperDisplayPage extends StatefulWidget {
  const HousekeeperDisplayPage({super.key});

  @override
  State<HousekeeperDisplayPage> createState() => _HousekeeperDisplayPageState();
}

class _HousekeeperDisplayPageState extends State<HousekeeperDisplayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HouseKeeperPageController>(
        init: HouseKeeperPageController(),
        builder: (controller) {
          return SizedBox(
            height: AppDimension.appHeight,
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimension.defaultPadding),
                  width: AppDimension.appWidth,
                  height: AppDimension.appHeight * 0.2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blueAccent.withOpacity(0.4),
                        Colors.blue.withOpacity(0.4),
                        Colors.white.withOpacity(0.4),
                        Colors.orangeAccent.withOpacity(0.4),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Obx(
                  () => Positioned(
                    top: AppDimension.appHeight * 0.2 - 60,
                    left: 0,
                    right: 0,
                    bottom: 50,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 8,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(60),
                                  border: Border.all(color: Colors.white, width: 1.5),
                                  image: controller.user.value?.avatar == null
                                      ? const DecorationImage(
                                          image: AssetImage(AppStrings.logoLight),
                                          fit: BoxFit.fill,
                                        )
                                      : DecorationImage(
                                          image: NetworkImage(controller.user.value?.avatar ?? ''),
                                          fit: BoxFit.fill,
                                        ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 2,
                                      blurRadius: 2,
                                      offset: const Offset(-2, 2),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AnimatedText(
                                      text:
                                          '${controller.user.value?.firstname?.toUpperCase()} ${controller.user.value?.lastname}',
                                      repeat: false,
                                      animationType: AnimationType.typerAnimation,
                                      bold: true,
                                      textColor: Colors.black,
                                      textSize: AppDimension.largeText,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '${controller.user.value?.email}',
                                          style: const TextStyle(
                                            fontSize: AppDimension.smallText,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        controller.user.value?.emailVerifiedAt == null
                                            ? const SizedBox()
                                            : const Icon(
                                                Icons.verified_outlined,
                                                size: AppDimension.smallIcon,
                                                color: Colors.green,
                                              ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          MyUtilities.parseDate(controller.user.value?.birthdate),
                                          style: const TextStyle(
                                            fontSize: AppDimension.smallText,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Text(
                                          ' | ${controller.user.value?.role}',
                                          style: const TextStyle(
                                            fontSize: AppDimension.smallText,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 120,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppDimension.defaultPadding,
                                vertical: AppDimension.defaultPadding,
                              ),
                              width: AppDimension.appWidth,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const Text(
                                                "Age: ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: AppDimension.mediumText,
                                                ),
                                              ),
                                              Text(
                                                '${MyUtilities.getAge(controller.user.value?.birthdate)} years',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: AppDimension.mediumText,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                "Nationality: ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: AppDimension.mediumText,
                                                ),
                                              ),
                                              Text(
                                                '${controller.keeper.value?.nationality}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: AppDimension.mediumText,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                "Province: ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: AppDimension.mediumText,
                                                ),
                                              ),
                                              Text(
                                                controller.keeper.value?.province ?? '',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: AppDimension.mediumText,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                "Religion: ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: AppDimension.mediumText,
                                                ),
                                              ),
                                              Text(
                                                '${controller.keeper.value?.religion}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: AppDimension.mediumText,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                "Phone: ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: AppDimension.mediumText,
                                                ),
                                              ),
                                              Text(
                                                '${controller.user.value?.phone}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: AppDimension.mediumText,
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              controller.user.value?.phoneVerifiedAt == null
                                                  ? const SizedBox()
                                                  : const Icon(
                                                      Icons.verified_outlined,
                                                      size: AppDimension.smallIcon,
                                                      color: Colors.blue,
                                                    ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              const Text(
                                                "Pseudo: ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: AppDimension.mediumText,
                                                ),
                                              ),
                                              Text(
                                                '${controller.user.value?.username}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: AppDimension.mediumText,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                          RatingStars(rating: controller.keeper.value?.rating ?? 0),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text(
                                      'Here let me put some small descriptions Here let me put some small descriptions Here'
                                      ' let me put some small descriptions Here let me put some small descriptions Here let '
                                      'me put some small descriptions Here let me put some small descriptions Here let me put'
                                      ' some small descriptions Here let me put some small descriptions',
                                      style:
                                          TextStyle(fontSize: AppDimension.mediumText, fontWeight: FontWeight.normal),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Address Information',
                                          style: TextStyle(
                                            fontSize: AppDimension.largeText,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Divider(height: 1, color: Colors.black, thickness: 2),
                                        Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        const Text(
                                                          "Country: ",
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.normal,
                                                            fontStyle: FontStyle.normal,
                                                            fontSize: AppDimension.mediumText,
                                                          ),
                                                        ),
                                                        const Icon(Icons.place,
                                                            size: AppDimension.smallIcon, color: Colors.blue),
                                                        Text(
                                                          controller.address.value.country ?? 'Undefined',
                                                          style: const TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontStyle: FontStyle.normal,
                                                            fontSize: AppDimension.mediumText,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        const Text(
                                                          "Province: ",
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.normal,
                                                            fontStyle: FontStyle.normal,
                                                            fontSize: AppDimension.mediumText,
                                                          ),
                                                        ),
                                                        Text(
                                                          controller.address.value.province ?? 'Undefined',
                                                          style: const TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontStyle: FontStyle.normal,
                                                            fontSize: AppDimension.mediumText,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        const Text(
                                                          "City: ",
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.normal,
                                                            fontStyle: FontStyle.normal,
                                                            fontSize: AppDimension.mediumText,
                                                          ),
                                                        ),
                                                        const Icon(Icons.map,
                                                            size: AppDimension.smallIcon, color: Colors.blue),
                                                        Text(
                                                          controller.address.value.city ?? 'Undefined',
                                                          style: const TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontStyle: FontStyle.normal,
                                                            fontSize: AppDimension.mediumText,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          "Post Code: ",
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.normal,
                                                            fontStyle: FontStyle.normal,
                                                            fontSize: AppDimension.mediumText,
                                                          ),
                                                        ),
                                                        Text(
                                                          controller.address.value.postalCode ?? 'xxxxxx',
                                                          style: const TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontStyle: FontStyle.normal,
                                                            fontSize: AppDimension.mediumText,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        const Text(
                                                          "Fax: ",
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.normal,
                                                            fontStyle: FontStyle.normal,
                                                            fontSize: AppDimension.mediumText,
                                                          ),
                                                        ),
                                                        const Icon(
                                                          Icons.fax,
                                                          size: AppDimension.smallIcon,
                                                          color: Colors.blue,
                                                        ),
                                                        Text(
                                                          controller.address.value.fax ?? 'xxx x xxx',
                                                          style: const TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontStyle: FontStyle.normal,
                                                            fontSize: AppDimension.mediumText,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  "Full Address : ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.normal,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: AppDimension.mediumText,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    controller.address.value.fullAddress ?? '',
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: AppDimension.mediumText,
                                                    ),
                                                    maxLines: 2,
                                                    overflow: TextOverflow.fade,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Reviews',
                                        style: TextStyle(
                                          fontSize: AppDimension.largeText,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Divider(height: 1, color: Colors.black, thickness: 2),
                                      Column(
                                        children: [
                                          Card(
                                            shape: Border.all(style: BorderStyle.none),
                                            child: Container(
                                              width: AppDimension.appWidth,
                                              padding: const EdgeInsets.all(8.0),
                                              child: const Text('Some content here'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Material(
                    elevation: 20,
                    animationDuration: const Duration(seconds: 5),
                    child: Container(
                      width: AppDimension.appWidth,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyButton(
                              text: 'Open Task',
                              btnColor: Colors.orangeAccent.withOpacity(0.5),
                              onClick: controller.openTask,
                            ),
                            MyButton(
                              text: 'Open Chat',
                              onClick: () => controller.openChat,
                              btnColor: Colors.greenAccent,
                              textColor: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Return Button
                Positioned(
                  top: 40,
                  left: 20,
                  child: InkWell(
                    onTap: () => Get.back(),
                    child: Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Colors.blue,
                        size: AppDimension.mediumIcon,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
