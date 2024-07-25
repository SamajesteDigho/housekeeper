import 'package:get/get.dart';
import 'package:housekeeper/brain/data/models/user.dart';
import 'package:housekeeper/brain/data/preferences/user_preferences.dart';
import 'package:housekeeper/brain/helpers/dio.dart';

class UserAPI extends GetxService {
  UserAPI();
  static final HttpUtil http = HttpUtil();

  static Future<bool> updateUserNameAttributes({required String userRef, required Map<String, dynamic> data}) {
    String URL = 'users/$userRef';
    return http.post(URL, data: data).then((response) {
      var data = response['data'];
      print("Here the response" + response);
      if (response['status_code'] == 200) {
        UserModel user = UserModel.fromJSON(data['result']);
        UserPreference.to.saveProfile(profile: user);
        print(user);
        return true;
      }
      return false;
    });
  }
}
