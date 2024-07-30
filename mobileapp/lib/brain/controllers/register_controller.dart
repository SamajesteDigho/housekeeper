import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/api/auth_api.dart';
import 'package:housekeeper/brain/api/user_api.dart';
import 'package:housekeeper/brain/routes/names.dart';

class RegisterController extends GetxController {
  RegisterController();

  final formKey = GlobalKey<FormState>();

  String? firstname;
  String? lastname;
  String? username;
  String? email;
  String? phone;
  String? password;

  RxString errorString = ''.obs;

  login() {
    Get.toNamed(AppRoutes.login);
  }

  register() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    Map<String, dynamic> data = {
      'firstname': firstname,
      'lastname': lastname,
      'username': username,
      'email': email,
      'phone': phone,
      'password': password,
    };
    AuthAPI.register(info: data).then((result) {
      if (result != null) {
        errorString.value = result;
      } else {
        Get.toNamed(AppRoutes.home);
      }
    });
  }
}