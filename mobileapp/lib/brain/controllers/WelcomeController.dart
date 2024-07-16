import 'package:get/get.dart';
import 'package:housekeeper/brain/data/models/user.dart';
import 'package:housekeeper/brain/data/preferences/user_preferences.dart';
import 'package:housekeeper/brain/data/repositories/welcome_repository.dart';
import 'package:housekeeper/brain/routes/names.dart';

class WelcomeController extends GetxController {
  WelcomeController({required this.welcomeRepository});
  final WelcomeRepository welcomeRepository;

  bool isLoggedIn = UserPreference.to.isLoggedIn;

  @override
  void onInit() {
    welcomeRepository.ping();
    super.onInit();
  }

  void clickLogin () {
    Get.toNamed(AppRoutes.login);
  }

  void clickHome() {
    Get.toNamed(AppRoutes.home);
  }

  void clickRegister () {
    Get.toNamed(AppRoutes.register);
  }
}