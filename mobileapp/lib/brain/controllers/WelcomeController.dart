import 'package:get/get.dart';
import 'package:housekeeper/brain/routes/names.dart';

class WelcomeController extends GetxController {
  WelcomeController();

  void clickLogin () {
    Get.to(AppRoutes.login);
  }

  void clickRegister () {
    Get.to(AppRoutes.register);
  }
}