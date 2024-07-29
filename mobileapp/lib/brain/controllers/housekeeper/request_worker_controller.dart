import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/api/house_keeper_api.dart';
import 'package:housekeeper/brain/constants/strings.dart';
import 'package:housekeeper/brain/data/models/user.dart';
import 'package:housekeeper/brain/data/preferences/user_preferences.dart';
import 'package:image_picker/image_picker.dart';

class RequestWorkerPageController extends GetxController {
  RequestWorkerPageController();

  final formKeyStep1 = GlobalKey<FormState>();
  final formKeyStep2 = GlobalKey<FormState>();
  final formKeyStep3 = GlobalKey<FormState>();

  UserModel user = UserPreference.to.profile;
  Rx<UserModel> validatedUser = UserPreference.to.profile.obs;
  ImagePicker picker = ImagePicker();

  RxInt currentPage = 0.obs;
  int maxSteps = 3;

  String? firstname;
  String? lastname = '';
  String? email = '';
  String? phone = '';
  String? birthdate = '';

  String? nationality = '';
  String? province = '';
  String? religion = '';
  String? countryRes = '';
  String? provinceRes = '';
  String? cityRes = '';
  String? fullAddress = '';
  String? fax = '';
  String? postCode = '';

  Rx<File> idDoc = File(AppStrings.idDocModel).obs;

  Map<String, dynamic> userInfoCollected = {};
  Map<String, dynamic> userMoreCollected = {};
  Map<String, dynamic> userIdCollected = {};

  @override
  onInit() {
    super.onInit();
    firstname = user.firstname;
    lastname = user.lastname;
    email = user.email;
    phone = user.phone;
    birthdate = user.birthdate.toString();
    nationality = user.keeper?.nationality;
    province = user.keeper?.province;
    religion = user.keeper?.religion;
    countryRes = user.address?.country;
    provinceRes = user.address?.province;
    cityRes = user.address?.city;
    fullAddress = user.address?.fullAddress;
    fax = user.address?.fax;
    postCode = user.address?.postalCode;
  }

  back() {
    currentPage.value == 0 ? currentPage.value = 0 : currentPage.value -= 1;
  }

  next() async {
    if (currentPage.value == 0) {
      if (!formKeyStep1.currentState!.validate()) {
        return false;
      }
      currentPage.value = 1;
    } else if (currentPage.value == 1) {
      if (!formKeyStep2.currentState!.validate()) {
        return false;
      }
      currentPage.value = 2;
    } else if (currentPage.value == 2) {
      if (idDoc.value.path == AppStrings.idDocModel) {
        Get.snackbar(
          "Error",
          'Please select/take and identification document',
          backgroundColor: Colors.red.withOpacity(0.5),
          colorText: Colors.white,
        );
        return;
      } else {
        userIdCollected = {'id_doc': idDoc};
        Map<String, dynamic> data = {
          'firstname': firstname!.isEmpty ? null : firstname,
          'lastname': lastname!.isEmpty ? null : lastname,
          'email': email!.isEmpty ? null : email,
          'phone': phone!.isEmpty ? null : phone,
          'birthdate': user.birthdate?.toIso8601String(),
          'nationality': nationality!.isEmpty ? null : nationality,
          'province': province!.isEmpty ? null : province,
          'religion': religion!.isEmpty ? null : religion,
          'country': countryRes!.isEmpty ? null : countryRes,
          'province_res': provinceRes!.isEmpty ? null : provinceRes,
          'city': cityRes!.isEmpty ? null : cityRes,
          'full_address': fullAddress!.isEmpty ? null : fullAddress,
          'fax': fax,
          'postal_code': postCode,
          'id_doc': await dio.MultipartFile.fromFile(idDoc.value.path)
        };
        currentPage.value = 3;
        HouseKeeperAPI.startKeeperRequest(userRef: '${user.ref}', info: data).then((value) {
          validatedUser.value = UserPreference.to.profile;
          refresh();
        });
      }
    } else {}
  }

  onStepReached(int step) {
    currentPage.value = step;
  }

  openGallery() async {
    XFile? image;
    image = await picker.pickImage(source: ImageSource.gallery);
    image != null ? idDoc.value = File(image.path) : idDoc.value = File(AppStrings.idDocModel);
  }

  openCamera() async {
    XFile? image;
    image = await picker.pickImage(source: ImageSource.camera);
    image != null ? idDoc.value = File(image.path) : idDoc.value = File(AppStrings.idDocModel);
  }

  submitOfInformation() {}
}
