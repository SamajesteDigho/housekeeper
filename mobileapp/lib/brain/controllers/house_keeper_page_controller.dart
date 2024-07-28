import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/data/models/address.dart';
import 'package:housekeeper/brain/data/models/keepers.dart';
import 'package:housekeeper/brain/data/models/user.dart';
import 'package:housekeeper/brain/routes/names.dart';

class HouseKeeperPageController extends GetxController {
  HouseKeeperPageController();

  final formKey = GlobalKey<FormState>();

  Rx<KeeperModel> keeper = KeeperModel().obs;
  Rx<UserModel?> user = UserModel().obs;
  Rx<AddressModel> address = AddressModel().obs;
  var args = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    user.value = args['user'];
    keeper.value = user.value?.keeper ?? KeeperModel();
    address.value = user.value?.address ?? AddressModel();
  }

  void openTask() {
    Get.toNamed(AppRoutes.openNewTask, arguments: {'worker': user});
  }

  void openChat() {}
}
