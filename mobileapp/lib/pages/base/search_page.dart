import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/controllers/HomeController.dart';
import 'package:housekeeper/pages/components/bottom_navigation_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return const Text("Here the home page");
      }
    );
  }

}