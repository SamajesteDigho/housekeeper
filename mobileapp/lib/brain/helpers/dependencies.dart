import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:housekeeper/brain/api/auth_api.dart';
import 'package:housekeeper/brain/api/house_keeper_api.dart';
import 'package:housekeeper/brain/api/task_api.dart';
import 'package:housekeeper/brain/api/user_api.dart';
import 'package:housekeeper/brain/controllers/account_oage_controller.dart';
import 'package:housekeeper/brain/controllers/home_controller.dart';
import 'package:housekeeper/brain/controllers/house_keeper_page_controller.dart';
import 'package:housekeeper/brain/controllers/layout_controller.dart';
import 'package:housekeeper/brain/controllers/login_controller.dart';
import 'package:housekeeper/brain/controllers/task_controller.dart';
import 'package:housekeeper/brain/controllers/register_controller.dart';
import 'package:housekeeper/brain/controllers/search_controller.dart';
import 'package:housekeeper/brain/controllers/welcome_controller.dart';
import 'package:housekeeper/brain/controllers/housekeeper/request_worker_controller.dart';
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