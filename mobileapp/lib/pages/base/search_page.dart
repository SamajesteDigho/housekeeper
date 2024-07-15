import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/constants/dimensions.dart';
import 'package:housekeeper/brain/constants/strings.dart';
import 'package:housekeeper/brain/controllers/SearchController.dart';
import 'package:housekeeper/pages/components/my_input_text_field.dart';
import 'package:housekeeper/pages/components/testimony.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MySearchController>(
      init: MySearchController(),
      builder: (controller) {
        return CustomScrollView(
          slivers: <Widget>[
            const SliverAppBar(
              pinned: true,
              toolbarHeight: 100,
              title: HeaderSliver(),
            ),
            SliverToBoxAdapter(
              child: Container(
                width: AppDimension.appWidth,
                height: AppDimension.appHeight,
                padding: const EdgeInsets.symmetric(horizontal: AppDimension.defaultPadding / 2),
                margin: const EdgeInsets.symmetric(vertical: AppDimension.defaultPadding),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.green.withOpacity(0.5),
                      Colors.red.withOpacity(0.5),
                      Colors.yellow.withOpacity(0.5),
                    ],
                  ),
                ),
                child: GridView.count(
                  primary: false,
                  crossAxisSpacing: 1,
                  padding: EdgeInsets.zero,
                  crossAxisCount: 2,
                  children: const <Widget> [
                    Testimony(name: 'name', text: 'text', ratings: 2),
                    Testimony(name: 'name', text: 'text', ratings: 2),
                    Testimony(name: 'name', text: 'text', ratings: 2),
                    Testimony(name: 'name', text: 'text', ratings: 2),
                    Testimony(name: 'name', text: 'text', ratings: 2),
                    Testimony(name: 'name', text: 'text', ratings: 2),
                    Testimony(name: 'name', text: 'text', ratings: 2),
                    Testimony(name: 'name', text: 'text', ratings: 2),
                  ],
                ),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: AppDimension.smallLogoSize,
          height: AppDimension.smallLogoSize,
          margin: const EdgeInsets.only(right: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimension.smallLogoSize),
            image: const DecorationImage(image: AssetImage(AppStrings.logoDark)),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => {},
                    child: const Icon(Icons.filter_alt_outlined),
                  ),
                  Expanded(
                    child: Container(
                      height: 25,
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              "All",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: AppDimension.smallText,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              "Names",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: AppDimension.smallText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 4.0),
                height: 50,
                child: Row(
                  children: [
                    const Expanded(
                      child: MyInputTextField(
                        label: 'Search',
                        icon: Icons.search,
                        maxNumberOfLine: 1,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.greenAccent.withOpacity(0.5),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () => {},
                        child: const Text("Search"),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
    ;
  }
}
