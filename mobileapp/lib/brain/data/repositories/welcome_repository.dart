import 'dart:io';

import 'package:get/get.dart';
import 'package:housekeeper/brain/helpers/dio.dart';

class WelcomeRepository extends GetxService {
  WelcomeRepository();
  static final HttpUtil http = HttpUtil();
  // final MemberRepository memberRepository = MemberRepository.to;
  // Define functions for managing the data on the layout yield

  Future ping() async {
    var response = await http.get('https://catfact.ninja/fact');
    print(response);
  }
}