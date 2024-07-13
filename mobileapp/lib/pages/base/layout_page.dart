import 'package:flutter/material.dart';
import 'package:housekeeper/pages/components/bottom_navigation_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text(
          "Here the home"
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }

}