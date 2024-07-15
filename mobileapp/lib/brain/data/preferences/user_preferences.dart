import 'package:get/get.dart';
import 'package:housekeeper/brain/constants/strings.dart';
import 'package:housekeeper/brain/data/models/user.dart';
import 'package:housekeeper/brain/data/preferences/storage_service.dart';
import 'package:housekeeper/brain/routes/names.dart';

class UserPreference extends GetxController {
  static UserPreference get to => Get.find();

  final _isLogin = false.obs;
  final _profile = User().obs;
  final _deviceToken = ''.obs;

  User get profile => _profile.value;
  bool get login => _isLogin.value;
  String get deviceToken => _deviceToken.value;

  @override
  void onInit() {
    super.onInit();
    var element = StorageService.to.getString(key: AppStrings.PREF_USER_PROFILE_KEY);
    if (element.isNotEmpty) {
      _isLogin.value = true;
      // _profile(User.fromJson(jsonDecode(element)));
    }
    _deviceToken.value = StorageService.to.getString(key: AppStrings.PREF_USER_DEVICETOKEN_KEY) ?? '';
  }

  /// Saving user profile to local storage
  Future<void> saveProfile({required User profile}) async {
    // await StorageService.to.setString(key: AppStrings.PREF_USER_PROFILE_KEY, value: jsonEncode(profile));
    _isLogin.value = true;
    _profile.value = profile;
  }

  /// Saving user device token to local storage
  Future<void> saveDeviceToken({required String token}) async {
    await StorageService.to.setString(key: AppStrings.PREF_USER_DEVICETOKEN_KEY, value: token);
    _deviceToken.value = token;
  }

  /// Getting user profile from local storage
  void getProfile() {
    var element = StorageService.to.getString(key: AppStrings.PREF_USER_PROFILE_KEY);
    if (element.isNotEmpty) {
      _isLogin.value = true;
      // _profile.value = User.fromJson(jsonDecode(element));
    }
  }

  /// On User Logout, Clear the User Profile
  Future<void> logoutProfile() async {
    await StorageService.to.remove(key: AppStrings.PREF_USER_PROFILE_KEY);
    await StorageService.to.remove(key: AppStrings.PREF_USER_DEVICETOKEN_KEY);
    _profile.value = User();
    _deviceToken.value = '';
    _isLogin.value = false;
    Get.offAllNamed(AppRoutes.login);
  }
}