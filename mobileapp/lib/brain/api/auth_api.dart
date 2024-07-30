import 'package:get/get.dart';
import 'package:housekeeper/brain/data/models/user.dart';
import 'package:housekeeper/brain/data/preferences/user_preferences.dart';
import 'package:housekeeper/brain/helpers/dio.dart';

class AuthAPI extends GetxService {
  AuthAPI();
  static final HttpUtil http = HttpUtil();

  static Future<dynamic> login(String pseudo, String password) async {
    String url = 'auth/login';
    Map<String, dynamic> data = {'pseudo': pseudo, 'password': password};
    var response = await http.post(url, data: data);
    if (response['status_code'] == 200) {
      Map<String, dynamic> result = response['data'];
      UserModel user = UserModel.fromJSON(result['result']);
      String token = result['token'];
      UserPreference.to.saveProfile(profile: user);
      UserPreference.to.saveAuthToken(token: token);
      return null;
    } else {
      return response['message'];
    }
  }

  static Future<dynamic> register({required Map<String, dynamic> info}) async {
    String url = 'auth/register';
    var response = await http.post(url, data: info);
    if (response['status_code'] == 200 || response['status_code'] == 201) {
      Map<String, dynamic> result = response['data'];
      UserModel user = UserModel.fromJSON(result['result']);
      String token = result['token'];
      UserPreference.to.saveProfile(profile: user);
      UserPreference.to.saveAuthToken(token: token);
      return null;
    } else {
      return response['message'];
    }
  }
}
