import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/api/AuthAPI.dart';
import 'package:housekeeper/brain/routes/names.dart';

class LoginController extends GetxController {
  LoginController();

  final formKey = GlobalKey<FormState>();
  String pseudo = '';
  String password = '';
  RxString errorString = ''.obs;

  login() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    AuthAPI.login(pseudo, password).then((result) {
      if (result != null) {
        errorString.value = result;
      } else {
        Get.toNamed(AppRoutes.home);
      }
    });
  }

  register() {
    Get.toNamed(AppRoutes.register);
  }
}
