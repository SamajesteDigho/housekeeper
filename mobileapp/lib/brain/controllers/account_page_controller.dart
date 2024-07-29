import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/data/models/user.dart';
import 'package:housekeeper/brain/data/preferences/user_preferences.dart';
import 'package:housekeeper/brain/routes/names.dart';

class AccountPageController extends GetxController {
  AccountPageController();

  final formKey = GlobalKey<FormState>();

  Rx<UserModel> user = UserPreference.to.profile.obs;

  clickEditUser() {
    if (kDebugMode) {
      print('Editing');
    }
  }

  becomeHouseKeeper() {
    Get.toNamed(AppRoutes.requestWorker)?.then((value) => user.value = UserPreference.to.profile);
  }

  houseKeeperDetails() {
    if (kDebugMode) {
      print("Becoming House keeper");
    }
  }

  activityStatistics() {
    if (kDebugMode) {
      print("Activity Statistics");
    }
  }

  logout() {
    UserPreference.to.logoutProfile();
  }
}
