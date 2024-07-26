import 'dart:convert';

import 'package:get/get.dart';
import 'package:housekeeper/brain/constants/strings.dart';
import 'package:housekeeper/brain/data/models/keepers.dart';
import 'package:housekeeper/brain/data/models/user.dart';
import 'package:housekeeper/brain/data/preferences/storage_service.dart';
import 'package:housekeeper/brain/routes/names.dart';

class UserPreference extends GetxController {
  static UserPreference get to => Get.find();

  final RxBool _isLogin = false.obs;
  final Rx<UserModel> _profile = UserModel().obs;
  final Rx<KeeperModel?> _keeper = null.obs;
  final RxString _deviceToken = ''.obs;
  final RxString _authToken = ''.obs;

  UserModel get profile => _profile.value;
  KeeperModel? get keeper => _keeper.value;
  bool get isLoggedIn => _isLogin.value;
  String get deviceToken => _deviceToken.value;
  String get authToken => _authToken.value;

  @override
  void onInit() {
    super.onInit();
    var element = StorageService.to.getString(key: AppStrings.prefUserProfileKey);
    var kElement = StorageService.to.getString(key: AppStrings.prefKeeperProfileKey);
    if (element.isNotEmpty) {
      _isLogin.value = true;
      _profile(UserModel.fromJSON(jsonDecode(element)));
    }
    kElement.isNotEmpty ? _keeper.value = KeeperModel.fromJSON(jsonDecode(kElement)) : _keeper.value = null;
    _deviceToken.value = StorageService.to.getString(key: AppStrings.prefUserDeviceTokenKey);
    _authToken.value = StorageService.to.getString(key: AppStrings.prefUserAuthTokenKey);
  }

  /// Saving user profile to local storage
  Future<void> saveProfile({required UserModel profile}) async {
    await StorageService.to.setString(key: AppStrings.prefUserProfileKey, value: jsonEncode(profile.toJSON()));
    _isLogin.value = true;
    _profile.value = profile;
  }

  /// Saving keeper info to local storage
  Future<void> saveKeeper({required KeeperModel keeper}) async {
    await StorageService.to.setString(key: AppStrings.prefKeeperProfileKey, value: jsonEncode(keeper.toJSON()));
    _keeper.value = keeper;
  }

  /// Saving user device token to local storage
  Future<void> saveDeviceToken({required String token}) async {
    await StorageService.to.setString(key: AppStrings.prefUserDeviceTokenKey, value: token);
    _deviceToken.value = token;
  }

  Future<void> saveAuthToken({required String token}) async {
    await StorageService.to.setString(key: AppStrings.prefUserAuthTokenKey, value: token);
    _authToken.value = token;
  }

  /// Getting user profile from local storage
  void getProfile() {
    var element = StorageService.to.getString(key: AppStrings.prefUserProfileKey);
    var kElement = StorageService.to.getString(key: AppStrings.prefKeeperProfileKey);
    if (element.isNotEmpty) {
      _isLogin.value = true;
      _profile.value = UserModel.fromJSON(jsonDecode(element));
    }
    kElement.isNotEmpty ? _keeper.value = KeeperModel.fromJSON(jsonDecode(kElement)) : _keeper.value = null;
    _authToken.value = StorageService.to.getString(key: AppStrings.prefUserAuthTokenKey);
    _deviceToken.value = StorageService.to.getString(key: AppStrings.prefUserDeviceTokenKey);
  }

  /// On User Logout, Clear the User Profile
  Future<void> logoutProfile() async {
    await StorageService.to.remove(key: AppStrings.prefUserProfileKey);
    await StorageService.to.remove(key: AppStrings.prefKeeperProfileKey);
    await StorageService.to.remove(key: AppStrings.prefUserDeviceTokenKey);
    await StorageService.to.remove(key: AppStrings.prefUserDeviceTokenKey);
    _profile.value = UserModel();
    _keeper.value = null;
    _deviceToken.value = '';
    _authToken.value = '';
    _isLogin.value = false;
    Get.offAllNamed(AppRoutes.initial);
  }
}
