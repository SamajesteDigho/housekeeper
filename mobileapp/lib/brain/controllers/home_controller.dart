import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/api/house_keeper_api.dart';
import 'package:housekeeper/brain/data/models/keepers.dart';
import 'package:housekeeper/brain/data/models/user.dart';

class HomeController extends GetxController {
  HomeController();

  final formKey = GlobalKey<FormState>();

  RxList<UserModel> topKeepers = <UserModel>[].obs;
  RxList<UserModel> nearKeepers = <UserModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    initialAPICalls();
  }

  void initialAPICalls() {
    HouseKeeperAPI.topKeepers().then((value) => topKeepers.value = value);
    HouseKeeperAPI.nearKeepers().then((value) => nearKeepers.value = value);
  }
}