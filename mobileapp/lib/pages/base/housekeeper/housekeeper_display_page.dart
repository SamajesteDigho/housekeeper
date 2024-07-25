import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/constants/dimensions.dart';
import 'package:housekeeper/brain/constants/strings.dart';
import 'package:housekeeper/brain/controllers/HouseKeeperPageController.dart';
import 'package:housekeeper/brain/helpers/utilities.dart';
import 'package:housekeeper/pages/components/animate_text.dart';
import 'package:housekeeper/pages/components/my_button.dart';

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
                Positioned(
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
                                image: const DecorationImage(
                                  image: AssetImage(AppStrings.logoLight),
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
                                  Text(
                                    '${controller.user.value?.email}',
                                    style: const TextStyle(
                                        fontSize: AppDimension.smallText,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.normal),
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
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Here let me put some small descriptions Here let me put some small descriptions Here'
                                  ' let me put some small descriptions Here let me put some small descriptions Here let '
                                  'me put some small descriptions Here let me put some small descriptions Here let me put'
                                  ' some small descriptions Here let me put some small descriptions',
                                  style: TextStyle(fontSize: AppDimension.mediumText, fontWeight: FontWeight.normal),
                                  textAlign: TextAlign.justify,
                                ),
                                Text(
                                  'Here let me put some small descriptions Here let me put some small descriptions Here'
                                  ' let me put some small descriptions Here let me put some small descriptions Here let '
                                  'me put some small descriptions Here let me put some small descriptions Here let me put'
                                  ' some small descriptions Here let me put some small descriptions',
                                  style: TextStyle(fontSize: AppDimension.mediumText, fontWeight: FontWeight.normal),
                                  textAlign: TextAlign.justify,
                                ),
                                Text(
                                  'Here let me put some small descriptions Here let me put some small descriptions Here'
                                  ' let me put some small descriptions Here let me put some small descriptions Here let '
                                  'me put some small descriptions Here let me put some small descriptions Here let me put'
                                  ' some small descriptions Here let me put some small descriptions',
                                  style: TextStyle(fontSize: AppDimension.mediumText, fontWeight: FontWeight.normal),
                                  textAlign: TextAlign.justify,
                                ),
                                Text(
                                  'Here let me put some small descriptions Here let me put some small descriptions Here'
                                  ' let me put some small descriptions Here let me put some small descriptions Here let '
                                  'me put some small descriptions Here let me put some small descriptions Here let me put'
                                  ' some small descriptions Here let me put some small descriptions',
                                  style: TextStyle(fontSize: AppDimension.mediumText, fontWeight: FontWeight.normal),
                                  textAlign: TextAlign.justify,
                                ),
                                Text(
                                  'Here let me put some small descriptions Here let me put some small descriptions Here'
                                  ' let me put some small descriptions Here let me put some small descriptions Here let '
                                  'me put some small descriptions Here let me put some small descriptions Here let me put'
                                  ' some small descriptions Here let me put some small descriptions',
                                  style: TextStyle(fontSize: AppDimension.mediumText, fontWeight: FontWeight.normal),
                                  textAlign: TextAlign.justify,
                                ),
                                Text(
                                  'Here let me put some small descriptions Here let me put some small descriptions Here'
                                  ' let me put some small descriptions Here let me put some small descriptions Here let '
                                  'me put some small descriptions Here let me put some small descriptions Here let me put'
                                  ' some small descriptions Here let me put some small descriptions',
                                  style: TextStyle(fontSize: AppDimension.mediumText, fontWeight: FontWeight.normal),
                                  textAlign: TextAlign.justify,
                                ),
                                Text(
                                  'Here let me put some small descriptions Here let me put some small descriptions Here'
                                  ' let me put some small descriptions Here let me put some small descriptions Here let '
                                  'me put some small descriptions Here let me put some small descriptions Here let me put'
                                  ' some small descriptions Here let me put some small descriptions',
                                  style: TextStyle(fontSize: AppDimension.mediumText, fontWeight: FontWeight.normal),
                                  textAlign: TextAlign.justify,
                                ),
                                Text(
                                  'Here let me put some small descriptions Here let me put some small descriptions Here'
                                  ' let me put some small descriptions Here let me put some small descriptions Here let '
                                  'me put some small descriptions Here let me put some small descriptions Here let me put'
                                  ' some small descriptions Here let me put some small descriptions',
                                  style: TextStyle(fontSize: AppDimension.mediumText, fontWeight: FontWeight.normal),
                                  textAlign: TextAlign.justify,
                                ),
                                Text(
                                  'Here let me put some small descriptions Here let me put some small descriptions Here'
                                  ' let me put some small descriptions Here let me put some small descriptions Here let '
                                  'me put some small descriptions Here let me put some small descriptions Here let me put'
                                  ' some small descriptions Here let me put some small descriptions',
                                  style: TextStyle(fontSize: AppDimension.mediumText, fontWeight: FontWeight.normal),
                                  textAlign: TextAlign.justify,
                                ),
                                Text(
                                  'Here let me put some small descriptions Here let me put some small descriptions Here'
                                  ' let me put some small descriptions Here let me put some small descriptions Here let '
                                  'me put some small descriptions Here let me put some small descriptions Here let me put'
                                  ' some small descriptions Here let me put some small descriptions',
                                  style: TextStyle(fontSize: AppDimension.mediumText, fontWeight: FontWeight.normal),
                                  textAlign: TextAlign.justify,
                                ),
                                Text(
                                  'Here let me put some small descriptions Here let me put some small descriptions Here'
                                  ' let me put some small descriptions Here let me put some small descriptions Here let '
                                  'me put some small descriptions Here let me put some small descriptions Here let me put'
                                  ' some small descriptions Here let me put some small descriptions',
                                  style: TextStyle(fontSize: AppDimension.mediumText, fontWeight: FontWeight.normal),
                                  textAlign: TextAlign.justify,
                                ),
                                Text(
                                  'Here let me put some small descriptions Here let me put some small descriptions Here'
                                  ' let me put some small descriptions Here let me put some small descriptions Here let '
                                  'me put some small descriptions Here let me put some small descriptions Here let me put'
                                  ' some small descriptions Here let me put some small descriptions',
                                  style: TextStyle(fontSize: AppDimension.mediumText, fontWeight: FontWeight.normal),
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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
                              onClick: () => controller.openTask,
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
              ],
            ),
          );
        },
      ),
    );
  }
}
