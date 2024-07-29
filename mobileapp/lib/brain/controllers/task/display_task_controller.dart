import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/api/task_api.dart';
import 'package:housekeeper/brain/constants/dimensions.dart';
import 'package:housekeeper/brain/data/models/tasks.dart';
import 'package:housekeeper/brain/data/models/user.dart';
import 'package:housekeeper/brain/data/preferences/user_preferences.dart';
import 'package:housekeeper/brain/helpers/validators.dart';
import 'package:housekeeper/pages/components/my_button.dart';
import 'package:housekeeper/pages/components/my_input_text_field.dart';

class TaskDisplayController extends GetxController {
  TaskDisplayController();

  final formKey = GlobalKey<FormState>();

  var args = Get.arguments;
  Rx<TaskModel> task = TaskModel().obs;
  Rx<UserModel> worker = UserModel().obs;
  Rx<UserModel> client = UserModel().obs;
  Rx<UserModel> printableUser = UserModel().obs;
  UserModel currentUser = UserPreference.to.profile;

  RxInt stars = 0.obs;
  String appreciation = '';

  @override
  void onInit() {
    super.onInit();
    task.value = args['task'];
    worker.value = task.value.keeper ?? UserModel();
    client.value = task.value.client ?? UserModel();
    currentUser.ref == client.value.ref ? printableUser.value = worker.value : printableUser.value = client.value;
  }

  Color getColorForState() {
    if (task.value.start!.isAfter(DateTime.now())) {
      return Colors.blue;
    } else if (task.value.end!.isAfter(DateTime.now())) {
      return Colors.greenAccent;
    } else {
      return Colors.red;
    }
  }

  rejectTask() {
    Map<String, dynamic> data = {
      'client_ref': task.value.client?.ref,
      'keeper_ref': task.value.keeper?.ref,
      'task_ref': task.value.ref,
      'status': 'REFUSED'
    };
    return TaskAPI.changeStatus(taskRef: '${task.value.ref}', info: data).then((value) {
      if (value == null) {
        return false;
      } else {
        task.value = value;
        return true;
      }
    });
  }

  acceptTask() {
    Map<String, dynamic> data = {
      'client_ref': task.value.client?.ref,
      'keeper_ref': task.value.keeper?.ref,
      'task_ref': task.value.ref,
      'status': 'ACCEPTED'
    };
    return TaskAPI.changeStatus(taskRef: '${task.value.ref}', info: data).then((value) {
      if (value == null) {
        return false;
      } else {
        task.value = value;
        return true;
      }
    });
  }

  startTask() {
    Map<String, dynamic> data = {
      'client_ref': task.value.client?.ref,
      'keeper_ref': task.value.keeper?.ref,
      'task_ref': task.value.ref,
      'status': 'ONGOING'
    };
    return TaskAPI.changeStatus(taskRef: '${task.value.ref}', info: data).then((value) {
      if (value == null) {
        return false;
      } else {
        task.value = value;
        return true;
      }
    });
  }

  stopTask() {
    Map<String, dynamic> data = {
      'client_ref': task.value.client?.ref,
      'keeper_ref': task.value.keeper?.ref,
      'task_ref': task.value.ref,
      'status': 'PRE-EMPTED'
    };
    return TaskAPI.changeStatus(taskRef: '${task.value.ref}', info: data).then((value) {
      if (value == null) {
        return false;
      } else {
        task.value = value;
        return true;
      }
    });
  }

  finishTask() {
    Map<String, dynamic> data = {
      'client_ref': task.value.client?.ref,
      'keeper_ref': task.value.keeper?.ref,
      'task_ref': task.value.ref,
      'status': 'COMPLETED'
    };
    return TaskAPI.changeStatus(taskRef: '${task.value.ref}', info: data).then((value) {
      if (value == null) {
        return false;
      } else {
        task.value = value;
        return true;
      }
    });
  }

  saveAppreciation() {
    if(!formKey.currentState!.validate()){
      return ;
    }
    Map<String, dynamic> data = {
      'appreciation': appreciation,
      'rating': double.parse('${stars.value}.0'),
      'task_ref': task.value.ref
    };
    return TaskAPI.addAppreciation(taskRef: '${task.value.ref}', info: data).then((value) {
      if (value == null) {
        Get.snackbar('Error', "Could not store appreciation", backgroundColor: Colors.redAccent);
      } else {
        task.value = value;
      }
      Get.back();
    });
  }

  addAppreciation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Add an Appreciation',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: AppDimension.largeText,
          ),
        ),
        shape: Border.all(style: BorderStyle.none),
        contentPadding: EdgeInsets.zero,
        content: Container(
          width: AppDimension.appWidth,
          padding: const EdgeInsets.symmetric(horizontal: AppDimension.defaultPadding),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                MyInputTextField(
                  label: 'Appreciation',
                  maxNumberOfLine: 10,
                  hint: 'Enter appreciation here',
                  padding: const EdgeInsets.all(8),
                  text: appreciation,
                  setText: (value) => appreciation = value,
                  validator: InputValidator.nameValidator,
                ),
                Row(
                  children: [
                    const Text(
                      'Rating : ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: AppDimension.largeText,
                      ),
                    ),
                    Obx(
                      () => Row(
                        children: [1, 2, 3, 4, 5]
                            .map(
                              (e) => InkWell(
                                onTap: () => stars.value = e,
                                child: e <= stars.value
                                    ? const Icon(Icons.star, color: Colors.green)
                                    : const Icon(Icons.star_border),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Obx(
                      () => Text(
                        '(${stars.value})',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: AppDimension.largeText,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        actions: [
          MyButton(text: 'Validate', onClick: saveAppreciation, btnColor: Colors.greenAccent, textColor: Colors.white)
        ],
      ),
    );
  }
}
