import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/api/task_api.dart';
import 'package:housekeeper/brain/data/models/user.dart';
import 'package:housekeeper/brain/data/preferences/user_preferences.dart';
import 'package:image_picker/image_picker.dart';

class CreateNewTaskController extends GetxController {
  CreateNewTaskController();

  final formKeyStep1 = GlobalKey<FormState>();
  final formKeyStep2 = GlobalKey<FormState>();
  final formKeyStep3 = GlobalKey<FormState>();

  var args = Get.arguments;
  UserModel user = UserPreference.to.profile;
  Rx<UserModel> worker = UserModel().obs;
  ImagePicker picker = ImagePicker();

  RxInt currentPage = 0.obs;
  int maxSteps = 2;

  String? taskDescription = '';
  DateTime? startDate;
  TimeOfDay? startTime;
  DateTime? endDate;
  TimeOfDay? endTime;
  RxString currency = 'USD'.obs;
  String pricePerHour = '';

  Map<String, dynamic> userInfoCollected = {};
  Map<String, dynamic> userMoreCollected = {};
  Map<String, dynamic> userIdCollected = {};

  @override
  onInit() {
    super.onInit();
    worker = args['worker'];
  }

  back() {
    currentPage.value == 0 ? currentPage.value = 0 : currentPage.value -= 1;
  }

  next() {
    if (currentPage.value == 0) {
      if (!formKeyStep1.currentState!.validate()) {
        return false;
      }
      currentPage.value = 1;
    } else if (currentPage.value == 1) {
      if (!formKeyStep2.currentState!.validate()) {
        return false;
      }
      if (startDate == null || endDate == null) {
        Get.snackbar('Error', 'End date and Start date must be selected', backgroundColor: Colors.redAccent);
        return;
      }
      if (startDate!.isAfter(endDate!)) {
        Get.snackbar('Error', 'End date must be after Start date', backgroundColor: Colors.redAccent);
      }
      currentPage.value = 2;
    } else {
      Map<String, dynamic> data = {
        'client_ref': user.ref,
        'keeper_ref': worker.value.ref,
        'description': taskDescription,
        'start':
            DateTime(startDate!.year, startDate!.month, startDate!.day, startTime?.hour ?? 0, startTime?.minute ?? 0)
                .toIso8601String(),
        'end': DateTime(endDate!.year, endDate!.month, endDate!.day, endTime?.hour ?? 0, endTime?.minute ?? 0)
            .toIso8601String(),
        'price_per_hour': double.tryParse(pricePerHour),
        'currency': currency.value,
        'reduction': 0.0,
      };
      TaskAPI.openNewTask(package: data).then((value) {
        if (value != null) {
          Get.snackbar('Successful', "Task Successfully Opened", backgroundColor: Colors.greenAccent);
          Get.back(result: value);
        } else {
          Get.snackbar('Failed', "Task could not be Opened", backgroundColor: Colors.redAccent);
        }
      });
    }
  }

  setStartDate(DateTime? date) {
    startDate = date;
    refresh();
  }

  setStartTime(TimeOfDay? time) {
    startTime = time;
    refresh();
  }

  setEndDate(DateTime? date) {
    endDate = date;
    refresh();
  }

  setEndTime(TimeOfDay? time) {
    endTime = time;
    refresh();
  }

  numberOfDaysOfWork() {
    if (startDate == null || endDate == null) return 0;
    return endDate?.difference(startDate!).inDays;
  }

  onStepReached(int step) {
    currentPage.value = step;
  }
}
