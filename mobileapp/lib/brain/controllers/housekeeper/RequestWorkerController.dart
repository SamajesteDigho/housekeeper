import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/api/UserAPI.dart';
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
  ImagePicker picker = ImagePicker();

  RxInt currentPage = 0.obs;
  int maxSteps = 3;

  String? firstname = '';
  String? lastname = '';
  String? email = '';
  String? phone = '';
  String? birthdate = '';

  String? nationality = '';
  String? province = '';
  String? religion = '';
  String? country_res = '';
  String? province_res = '';
  String? city_res = '';
  String? full_address = '';
  String? fax = '';
  String? post_code = '';

  Rx<File> id_doc = File(AppStrings.ID_DOC_EXAMPLE).obs;

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
  }

  back() {
    currentPage.value == 0 ? currentPage.value = 0 : currentPage.value -= 1;
  }

  next() {
    if (currentPage.value == 0) {
      if (!formKeyStep1.currentState!.validate()) {
        return false;
      }
      userInfoCollected = {
        'firstname': firstname!.isEmpty ? null : firstname,
        'lastname': lastname!.isEmpty ? null : lastname,
        'email': email!.isEmpty ? null : email,
        'phone': phone!.isEmpty ? null : phone,
        'birthdate': user.birthdate.toString(),
      };
      currentPage.value = 1;
    } else if (currentPage.value == 1) {
      if (!formKeyStep2.currentState!.validate()) {
        return false;
      }
      userMoreCollected = {
        'nationality': nationality!.isEmpty ? null : nationality,
        'province': province!.isEmpty ? null : province,
        'religion': religion!.isEmpty ? null : religion,
        'country': country_res!.isEmpty ? null : country_res,
        'province_res': province_res!.isEmpty ? null : province_res,
        'city': city_res!.isEmpty ? null : city_res,
        'full_address': full_address!.isEmpty ? null : full_address,
        'fax': fax,
        'postal_code': post_code
      };
      currentPage.value = 2;
    } else if (currentPage.value == 2) {
      if (id_doc.value.path == AppStrings.ID_DOC_EXAMPLE) {
        Get.snackbar(
          "Error",
          'Please select/take and identification document',
          backgroundColor: Colors.red.withOpacity(0.5),
          colorText: Colors.white,
        );
        return;
      } else {
        userIdCollected = {'id_doc': id_doc};
        currentPage.value = 3;
      }
    } else {}
  }

  onStepReached(int step) {
    currentPage.value = step;
  }

  openGallery() async {
    XFile? image;
    image = await picker.pickImage(source: ImageSource.gallery);
    image != null ? id_doc.value = File(image.path) : id_doc.value = File(AppStrings.ID_DOC_EXAMPLE);
  }

  openCamera() async {
    XFile? image;
    image = await picker.pickImage(source: ImageSource.camera);
    image != null ? id_doc.value = File(image.path) : id_doc.value = File(AppStrings.ID_DOC_EXAMPLE);
  }

  submitOfInformation() {}
}
