import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:housekeeper/brain/data/hive/hive_strings.dart';

class UserRepository extends GetxService {
  static UserRepository get to => Get.find();
  final userBox = Hive.box(hiveUserLabel);

  Future<UserRepository> init() async {
    return this;
  }
}
