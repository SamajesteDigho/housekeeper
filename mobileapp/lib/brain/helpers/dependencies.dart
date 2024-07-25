import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:housekeeper/brain/api/AuthAPI.dart';
import 'package:housekeeper/brain/api/HouseKeeperAPI.dart';
import 'package:housekeeper/brain/api/TaskAPI.dart';
import 'package:housekeeper/brain/api/UserAPI.dart';
import 'package:housekeeper/brain/controllers/AccountPageController.dart';
import 'package:housekeeper/brain/controllers/HomeController.dart';
import 'package:housekeeper/brain/controllers/HouseKeeperPageController.dart';
import 'package:housekeeper/brain/controllers/LayoutController.dart';
import 'package:housekeeper/brain/controllers/LoginController.dart';
import 'package:housekeeper/brain/controllers/TaskController.dart';
import 'package:housekeeper/brain/controllers/RegisterController.dart';
import 'package:housekeeper/brain/controllers/SearchController.dart';
import 'package:housekeeper/brain/controllers/WelcomeController.dart';
import 'package:housekeeper/brain/controllers/housekeeper/RequestWorkerController.dart';
import 'package:housekeeper/brain/data/hive/hive_strings.dart';
import 'package:housekeeper/brain/data/models/tasks.dart';
import 'package:housekeeper/brain/data/preferences/storage_service.dart';
import 'package:housekeeper/brain/data/preferences/user_preferences.dart';
import 'package:housekeeper/brain/data/repositories/layout_repository.dart';
import 'package:housekeeper/brain/data/repositories/welcome_repository.dart';

Future<void> initDependencies() async {
  // Load Hives Dependencies
  await Hive.initFlutter();
  // Hive.registerAdapter(OrderModelAdapter());
  // await Hive.openBox(hiveOrderLabel);

  // Services
  await Get.putAsync<StorageService>(() => StorageService().init());

  // Load Repositories
  Get.lazyPut(() => LayoutRepository());
  Get.lazyPut(() => WelcomeRepository());

  // API Repositories
  Get.lazyPut(() => UserPreference());
  Get.lazyPut(() => AuthAPI());
  Get.lazyPut(() => HouseKeeperAPI());
  Get.lazyPut(() => TaskAPI());
  Get.lazyPut(() => UserAPI());

  // Load Controllers
  Get.lazyPut(() => WelcomeController(welcomeRepository: Get.find()));
  Get.lazyPut(() => LoginController());
  Get.lazyPut(() => RegisterController());
  Get.lazyPut(() => LayoutController(layoutRepository: Get.find()));
  Get.lazyPut(() => HomeController());
  Get.lazyPut(() => MySearchController());
  Get.lazyPut(() => TaskController());
  Get.lazyPut(() => AccountPageController());
  Get.lazyPut(() => RequestWorkerPageController());
  Get.lazyPut(() => HouseKeeperPageController());
}