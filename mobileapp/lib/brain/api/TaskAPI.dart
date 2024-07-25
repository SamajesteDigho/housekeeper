import 'package:get/get.dart';
import 'package:housekeeper/brain/data/models/tasks.dart';
import 'package:housekeeper/brain/helpers/dio.dart';

class TaskAPI extends GetxService {
  TaskAPI();
  static final HttpUtil http = HttpUtil();

  static Future<List> searchMyTasks({required String myRef}) {
    String URL = 'tasks/$myRef/my_tasks';
    return http.get(URL).then((response) {
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
}
