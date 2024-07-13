import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/routes/names.dart';

class LoginController extends GetxController {
  LoginController();

  final formKey = GlobalKey<FormState>();

  login() {
    print('Login');
  }

  register() {
    Get.toNamed(AppRoutes.register);
  }
}