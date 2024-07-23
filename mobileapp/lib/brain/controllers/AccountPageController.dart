import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/api/HouseKeeperAPI.dart';
import 'package:housekeeper/brain/data/models/keepers.dart';
import 'package:housekeeper/brain/routes/names.dart';

class HomeController extends GetxController {
  HomeController();

  final formKey = GlobalKey<FormState>();

  RxList<KeeperModel> top_keepers = <KeeperModel>[].obs;
  RxList<KeeperModel> near_keepers = <KeeperModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    initialAPICalls();
  }

  void initialAPICalls() {
    HouseKeeperAPI.topKeepers().then((value) => top_keepers.value = value);
    HouseKeeperAPI.nearKeepers().then((value) => near_keepers.value = value);
  }
}