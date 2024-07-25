import 'dart:convert';

import 'package:get/get.dart';
import 'package:housekeeper/brain/constants/strings.dart';
import 'package:housekeeper/brain/data/models/user.dart';
import 'package:housekeeper/brain/data/preferences/storage_service.dart';
import 'package:housekeeper/brain/routes/names.dart';

class UserPreference extends GetxController {
  static UserPreference get to => Get.find();

  final _isLogin = false.obs;
  final _profile = UserModel().obs;
  final _deviceToken = ''.obs;
  final _authToken = ''.obs;

  UserModel get profile => _profile.value;
  bool get isLoggedIn => _isLogin.value;
  String get deviceToken => _deviceToken.value;
  String get authToken => _authToken.value;

  @override
  void onInit() {
    super.onInit();
    var element = StorageService.to.getString(key: AppStrings.PREF_USER_PROFILE_KEY);
    if (element.isNotEmpty) {
      _isLogin.value = true;
      _profile(UserModel.fromJSON(jsonDecode(element)));
    }
    _deviceToken.value = StorageService.to.getString(key: AppStrings.PREF_USER_DEVICETOKEN_KEY) ?? '';
    _authToken.value = StorageService.to.getString(key: AppStrings.PREF_USER_AUTHTOKEN_KEY) ?? '';
  }

  /// Saving user profile to local storage
  Future<void> saveProfile({required UserModel profile}) async {
    await StorageService.to.setString(key: AppStrings.PREF_USER_PROFILE_KEY, value: jsonEncode(profile.toJSON()));
    _isLogin.value = true;
    _profile.value = profile;
  }

  /// Saving user device token to local storage
  Future<void> saveDeviceToken({required String token}) async {
    await StorageService.to.setString(key: AppStrings.PREF_USER_DEVICETOKEN_KEY, value: token);
    _deviceToken.value = token;
  }

  Future<void> saveAuthToken({required String token}) async {
    await StorageService.to.setString(key: AppStrings.PREF_USER_AUTHTOKEN_KEY, value: token);
    _authToken.value = token;
  }

  /// Getting user profile from local storage
  void getProfile() {
    var element = StorageService.to.getString(key: AppStrings.PREF_USER_PROFILE_KEY);
    if (element.isNotEmpty) {
      _isLogin.value = true;
      _profile.value = UserModel.fromJSON(jsonDecode(element));
    }
    _authToken.value = StorageService.to.getString(key: AppStrings.PREF_USER_AUTHTOKEN_KEY) ?? '';
  }

  /// On User Logout, Clear the User Profile
  Future<void> logoutProfile() async {
    await StorageService.to.remove(key: AppStrings.PREF_USER_PROFILE_KEY);
    await StorageService.to.remove(key: AppStrings.PREF_USER_DEVICETOKEN_KEY);
    _profile.value = UserModel();
    _deviceToken.value = '';
    _authToken.value = '';
    _isLogin.value = false;
    Get.offAllNamed(AppRoutes.initial);
  }
}