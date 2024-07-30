import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/data/models/user.dart';
import 'package:housekeeper/brain/data/preferences/user_preferences.dart';
import 'package:housekeeper/brain/helpers/dio.dart';

class UserAPI extends GetxService {
  UserAPI();
  static final HttpUtil http = HttpUtil();

  static Future<bool> updateUserNameAttributes({required String userRef, required Map<String, dynamic> data}) {
    String url = 'users/$userRef';
    EasyLoading.show();
    return http.post(url, data: data).then((response) {
      var data = response['data'];
      if (kDebugMode) {
        print('Here the response $response');
      }
      if (response['status_code'] == 200) {
        UserModel user = UserModel.fromJSON(data['result']);
        UserPreference.to.saveProfile(profile: user);
        if (kDebugMode) {
          print(user);
        }
        return true;
      }
      return false;
    });
  }
}
