import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/api/UserAPI.dart';
import 'package:housekeeper/brain/data/models/user.dart';
import 'package:housekeeper/brain/data/preferences/user_preferences.dart';
import 'package:housekeeper/brain/routes/names.dart';

class AccountPageController extends GetxController {
  AccountPageController();

  final formKey = GlobalKey<FormState>();

  UserModel user = UserPreference.to.profile;

  clickEditUser() {
    print('Editing');
  }

  becomeHouseKeeper() {
    Get.toNamed(AppRoutes.requestWorker);
  }

  houseKeeperDetails() {
    print("Becoming House keeper");
  }

  activityStatistics() {
    print("Activity Statistics");
  }

  logout() {
    UserPreference.to.logoutProfile();
  }
}
