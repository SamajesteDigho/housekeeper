import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/data/repositories/layout_repository.dart';
import 'package:housekeeper/brain/routes/names.dart';
import 'package:housekeeper/pages/base/account_page.dart';
import 'package:housekeeper/pages/base/home_page.dart';
import 'package:housekeeper/pages/base/task_page.dart';
import 'package:housekeeper/pages/base/search_page.dart';

class LayoutController extends GetxController {
  final LayoutRepository layoutRepository;
  LayoutController({required this.layoutRepository});
  List<Widget> pages = const [
    HomePage(),
    SearchPage(),
    OrderPage(),
    AccountPage(),
  ];

  int _activePage = 0;
  int get activePage => _activePage;

  void changePage(int pageIndex) {
    if (pageIndex < 0) {
      _activePage = 0;
    } else if (pageIndex >= pages.length) {
      _activePage = pages.length - 1;
    } else {
      _activePage = pageIndex;
    }
    update();
  }

  backButton() {}
}
