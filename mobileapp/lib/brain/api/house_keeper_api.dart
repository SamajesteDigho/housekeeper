import 'package:get/get.dart';
import 'package:housekeeper/brain/data/models/keepers.dart';
import 'package:housekeeper/brain/data/models/user.dart';
import 'package:housekeeper/brain/data/preferences/user_preferences.dart';
import 'package:housekeeper/brain/helpers/dio.dart';

class HouseKeeperAPI extends GetxService {
  HouseKeeperAPI();
  static final HttpUtil http = HttpUtil();

  static Future<List<UserModel>> topKeepers() {
    String url = 'keepers/top/search';
    return http.get(url).then((response) {
      List<UserModel> users = [];
      var data = response['data'];
      if (response['status_code'] == 200) {
        List collected = data['result'];
        for (int i = 0; i < collected.length; i++) {
          users.add(UserModel.fromJSON(collected[i]));
        }
      }
      return users;
    });
  }

  static Future<List<UserModel>> nearKeepers() {
    String url = 'keepers/near/search';
    return http.get(url).then((response) {
      List<UserModel> users = [];
      var data = response['data'];
      if (response['status_code'] == 200) {
        List collected = data['result'];
        for (int i = 0; i < collected.length; i++) {
          users.add(UserModel.fromJSON(collected[i]));
        }
      }
      return users;
    });
  }

  static Future<List<UserModel>> searchData({String? searchTerm, List<String>? filter}) {
    String url = 'keepers/keeper/search';
    Map<String, dynamic> queryParams = {'searchTerm': searchTerm, 'filter': filter};
    return http.get(url, queryParams: queryParams).then((response) {
      List<UserModel> users = [];
      var data = response['data'];
      if (response['status_code'] == 200) {
        List collected = data['result'];
        for (int i = 0; i < collected.length; i++) {
          users.add(UserModel.fromJSON(collected[i]));
        }
      }
      return users;
    });
  }

  static Future<UserModel?> startKeeperRequest({required String userRef, required Map<String, dynamic> info}) {
    String url = 'keepers/$userRef/new';
    return http.postForm(url, data: info).then((response) {
      var data = response['data'];
      if (response['status_code'] == 200) {
        UserModel user = UserModel.fromJSON(data['result']);
        UserPreference.to.saveProfile(profile: user);
        return user;
      }
      return null;
    });
  }
}
