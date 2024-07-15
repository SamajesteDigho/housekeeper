import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/constants/dimensions.dart';
import 'package:housekeeper/brain/constants/strings.dart';
import 'package:housekeeper/brain/controllers/HomeController.dart';
import 'package:housekeeper/brain/controllers/LayoutController.dart';
import 'package:housekeeper/pages/components/advertisement_block.dart';
import 'package:housekeeper/pages/components/testimony.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return CustomScrollView(
          slivers: <Widget>[
            const SliverAppBar(
              pinned: true,
              title: HeaderSliver(),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const AdvertisementBlock(),

                  Container(
                    width: AppDimension.appWidth,
                    padding: const EdgeInsets.symmetric(horizontal: AppDimension.defaultPadding),
                    margin: const EdgeInsets.symmetric(vertical: AppDimension.defaultPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Top Workers',
                          style: TextStyle(fontSize: AppDimension.largeText, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 200,
                          decoration: const BoxDecoration(color: Colors.transparent),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: const <Widget>[
                              Testimony(
                                text: 'This is really interesting and usefull app. Thanks...',
                                name: 'Armanda Carmila',
                                ratings: 5,
                              ),
                              Testimony(
                                text: 'This is really interesting and usefull app. Thanks...',
                                name: 'Armanda Carmila',
                                ratings: 5,
                              ),
                              Testimony(
                                text: 'This is really interesting and usefull app. Thanks...',
                                name: 'Armanda Carmila',
                                ratings: 5,
                              ),
                              Testimony(
                                text: 'This is really interesting and usefull app. Thanks...',
                                name: 'Armanda Carmila',
                                ratings: 5,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    width: AppDimension.appWidth,
                    padding: const EdgeInsets.symmetric(horizontal: AppDimension.defaultPadding),
                    margin: const EdgeInsets.symmetric(vertical: AppDimension.defaultPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Near By Workers',
                          style: TextStyle(fontSize: AppDimension.largeText, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 200,
                          decoration: const BoxDecoration(color: Colors.transparent),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: const <Widget>[
                              Testimony(
                                text: 'This is really interesting and usefull app. Thanks...',
                                name: 'Armanda Carmila',
                                ratings: 5,
                              ),
                              Testimony(
                                text: 'This is really interesting and usefull app. Thanks...',
                                name: 'Armanda Carmila',
                                ratings: 5,
                              ),
                              Testimony(
                                text: 'This is really interesting and usefull app. Thanks...',
                                name: 'Armanda Carmila',
                                ratings: 5,
                              ),
                              Testimony(
                                text: 'This is really interesting and usefull app. Thanks...',
                                name: 'Armanda Carmila',
                                ratings: 5,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

class HeaderSliver extends StatelessWidget {
  const HeaderSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LayoutController>(
      builder: (controller) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: AppDimension.smallLogoSize,
              height: AppDimension.smallLogoSize,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppDimension.smallLogoSize),
                  image: const DecorationImage(image: AssetImage(AppStrings.logoDark))),
            ),
            const Text(
              'HOUSEKEEPER FINDER',
              style: TextStyle(fontSize: AppDimension.largeText, fontWeight: FontWeight.bold),
            ),
            InkWell(
              onTap: () => controller.changePage(1),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.black12),
                ),
                child: const Icon(Icons.search),
              ),
            ),
          ],
        );
      },
    );
  }
}
