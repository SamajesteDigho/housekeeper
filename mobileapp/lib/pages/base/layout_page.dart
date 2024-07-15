import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/controllers/LayoutController.dart';
import 'package:housekeeper/pages/components/bottom_navigation_bar.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LayoutController>(
        builder: (controller) {
          return SafeArea(
            child: controller.pages[controller.activePage],
          );
        }
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }

}