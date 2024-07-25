import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/api/HouseKeeperAPI.dart';
import 'package:housekeeper/brain/data/models/keepers.dart';
import 'package:housekeeper/brain/data/models/user.dart';
import 'package:housekeeper/brain/data/preferences/user_preferences.dart';
import 'package:housekeeper/brain/routes/names.dart';

class HouseKeeperPageController extends GetxController {
  HouseKeeperPageController();

  final formKey = GlobalKey<FormState>();

  Rx<KeeperModel> keeper = KeeperModel().obs;
  Rx<UserModel?> user = UserModel().obs;
  var args = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    keeper.value = args['keeper'];
    user.value = keeper.value.user;
  }

  void openTask() {}

  void openChat() {}
}
