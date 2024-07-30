import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/controllers/layout_controller.dart';
import 'package:housekeeper/pages/components/bottom_navigation_bar.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LayoutController>(
      init: LayoutController(layoutRepository: Get.find()),
      builder: (controller) {
        return PopScope(
          canPop: false,
          child: Scaffold(
            body: SafeArea(
              child: controller.pages[controller.activePage],
            ),
            bottomNavigationBar: const MyBottomNavigationBar(),
          ),
        );
      }
    );
  }
}
