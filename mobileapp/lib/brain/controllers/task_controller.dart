import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/api/task_api.dart';
import 'package:housekeeper/brain/data/models/tasks.dart';
import 'package:housekeeper/brain/data/models/user.dart';
import 'package:housekeeper/brain/data/preferences/user_preferences.dart';
import 'package:housekeeper/brain/routes/names.dart';

class TaskController extends GetxController {
  TaskController();

  final formKey = GlobalKey<FormState>();

  UserModel user = UserPreference.to.profile;
  RxBool isKeeper = false.obs;
  RxList<TaskModel> tasks = <TaskModel>[].obs;
  RxList<TaskModel> placedReceived = <TaskModel>[].obs;
  RxList<TaskModel> ongoing = <TaskModel>[].obs;
  RxList<TaskModel> completed = <TaskModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadMyTasks();
  }

  loadMyTasks() {
    TaskAPI.searchMyTasks(myRef: '${user.ref}').then((value) {
      placedReceived.value = value[0];
      ongoing.value = value[1];
      completed.value = value[2];
    });
  }

  checkISKeeper() {
    user.role == 'HOUSEKEEPER' ? isKeeper.value = true : isKeeper.value = false;
  }

  navigateToPage(TaskModel task) {
    Get.toNamed(AppRoutes.taskDisplay, arguments: {'task': task})?.then((value) => loadMyTasks());
  }
}
