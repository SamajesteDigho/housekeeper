import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/routes/names.dart';

class RegisterController extends GetxController {
  RegisterController();

  final formKey = GlobalKey<FormState>();

  login() {
    Get.toNamed(AppRoutes.login);
  }

  register() {
    if (kDebugMode) {
      print('Register');
    }
  }
}