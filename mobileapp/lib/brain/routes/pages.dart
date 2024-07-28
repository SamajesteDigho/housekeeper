import 'package:get/get.dart';
import 'package:housekeeper/brain/routes/names.dart';
import 'package:housekeeper/pages/auth/login_page.dart';
import 'package:housekeeper/pages/auth/register_page.dart';
import 'package:housekeeper/pages/base/housekeeper/housekeeper_display_page.dart';
import 'package:housekeeper/pages/base/housekeeper/request_worker_page.dart';
import 'package:housekeeper/pages/base/layout_page.dart';
import 'package:housekeeper/pages/base/tasks/create_new_task_page.dart';
import 'package:housekeeper/pages/welcome_page.dart';

class AppPages {
  static List<GetPage> pages =[
    GetPage(name: AppRoutes.initial, page: () => const WelcomePage()),
    GetPage(name: AppRoutes.login, page: () => const LoginPage()),
    GetPage(name: AppRoutes.register, page: () => const RegisterPage()),
    GetPage(name: AppRoutes.home, page: () => const LayoutPage()),
    GetPage(name: AppRoutes.requestWorker, page: () => const RequestWorkerPage()),
    GetPage(name: AppRoutes.houseKeeperPage, page: () => const HousekeeperDisplayPage()),
    GetPage(name: AppRoutes.openNewTask, page: () => const CreateNewTaskPage()),
  ];
}