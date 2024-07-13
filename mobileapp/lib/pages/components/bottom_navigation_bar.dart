import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msma/heart/constants/colors.dart';
import 'package:msma/heart/constants/dimensions.dart';
import 'package:msma/heart/controllers/layout_controller.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimension.bottomNavigationBarHeight,
      child: GetBuilder<LayoutController>(
        builder: (controller) => BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: Colors.black,
          showUnselectedLabels: true,
          currentIndex: controller.activePage,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.featured_play_list_outlined),
              activeIcon: Icon(Icons.featured_play_list),
              label: "Roaster",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_outlined),
              activeIcon: Icon(Icons.chat),
              label: "Chats",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_activity_outlined),
              activeIcon: Icon(Icons.local_activity),
              label: "Activity",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined, grade: 1),
              activeIcon: Icon(Icons.settings),
              label: "Settings",
            )
          ],
          onTap: (index) => controller.changePage(index),
        ),
      ),
    );
  }
}
