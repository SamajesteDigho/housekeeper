import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:housekeeper/brain/controllers/HomeController.dart';
import 'package:housekeeper/brain/controllers/LayoutController.dart';
import 'package:housekeeper/brain/controllers/LoginController.dart';
import 'package:housekeeper/brain/controllers/OrderController.dart';
import 'package:housekeeper/brain/controllers/RegisterController.dart';
import 'package:housekeeper/brain/controllers/SearchController.dart';
import 'package:housekeeper/brain/controllers/WelcomeController.dart';
import 'package:housekeeper/brain/data/hive/hive_strings.dart';
import 'package:housekeeper/brain/data/models/orders.dart';
import 'package:housekeeper/brain/data/preferences/storage_service.dart';
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

  // Load Controllers
  Get.lazyPut(() => WelcomeController(welcomeRepository: Get.find()));
  Get.lazyPut(() => LoginController());
  Get.lazyPut(() => RegisterController());
  Get.lazyPut(() => LayoutController(layoutRepository: Get.find()));
  Get.lazyPut(() => HomeController());
  Get.lazyPut(() => MySearchController());
  Get.lazyPut(() => OrderController());
}