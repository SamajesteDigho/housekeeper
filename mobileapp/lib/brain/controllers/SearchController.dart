import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/api/HouseKeeperAPI.dart';
import 'package:housekeeper/brain/data/models/keepers.dart';
import 'package:housekeeper/brain/routes/names.dart';

class MySearchController extends GetxController {
  MySearchController();

  final formKey = GlobalKey<FormState>();

  RxList<KeeperModel> search_result = <KeeperModel>[].obs;
  RxList<String> filters = <String>[].obs;
  List<String> filter_options = ['name', 'email', 'rating', 'nationality', 'religion'];
  String searchTerm = '';
  GlobalKey btnKey = GlobalKey();

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  processSearchOnValidate() {
    HouseKeeperAPI.searchData().then((value) => search_result.value = value);
  }

  selectUnselectFilter(String item) {
    filters.contains(item) ? filters.remove(item) : filters.add(item);
  }
}