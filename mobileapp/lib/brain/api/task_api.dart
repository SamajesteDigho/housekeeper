import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/data/models/tasks.dart';
import 'package:housekeeper/brain/helpers/dio.dart';

class TaskAPI extends GetxService {
  TaskAPI();
  static final HttpUtil http = HttpUtil();

  static Future<List> searchMyTasks({required String myRef}) {
    String url = 'tasks/$myRef/my_tasks';
    EasyLoading.show();
    return http.get(url).then((response) {
      List<TaskModel> orders = [];
      var data = response['data'];
      if (response['status_code'] == 200) {
        List collected = data['result'];
        for (int i = 0; i < collected.length; i++) {
          orders.add(TaskModel.fromJSON(collected[i]));
        }
      }
      return TaskModel.segmentTasks(orders);
    });
  }

  static Future<TaskModel?> openNewTask({required Map<String, dynamic> package}) {
    String url = 'tasks';
    EasyLoading.show();
    return http.post(url, data: package).then((response) {
      if (response['status_code'] == 200 || response['status_code'] == 201) {
        var data = response['data'];
        return TaskModel.fromJSON(data['result']);
      } else {
        return null;
      }
    });
  }

  static Future<TaskModel?> changeStatus({required String taskRef, required Map<String, dynamic> info}) {
    String url = 'tasks/$taskRef/set_status';
    EasyLoading.show();
    return http.post(url, data: info).then((response) {
      if (response['status_code'] == 200 || response['status_code'] == 201) {
        var data = response['data'];
        return TaskModel.fromJSON(data['result']);
      } else {
        return null;
      }
    });
  }

  static Future<TaskModel?> addAppreciation({required String taskRef, required Map<String, dynamic> info}) {
    String url = 'tasks/$taskRef/appreciate';
    EasyLoading.show();
    return http.post(url, data: info).then((response) {
      if (response['status_code'] == 200 || response['status_code'] == 201) {
        var data = response['data'];
        return TaskModel.fromJSON(data['result']);
      } else {
        return null;
      }
    });
  }
}
