import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/api/house_keeper_api.dart';
import 'package:housekeeper/brain/data/models/keepers.dart';

class MySearchController extends GetxController {
  MySearchController();

  final formKey = GlobalKey<FormState>();

  RxList<KeeperModel> searchResult = <KeeperModel>[].obs;
  RxList<String> filters = <String>[].obs;
  List<String> filterOptions = ['name', 'email', 'rating', 'nationality', 'religion'];
  String searchTerm = '';
  GlobalKey btnKey = GlobalKey();

  processSearchOnValidate() {
    HouseKeeperAPI.searchData().then((value) => searchResult.value = value);
  }

  selectUnselectFilter(String item) {
    filters.contains(item) ? filters.remove(item) : filters.add(item);
  }
}