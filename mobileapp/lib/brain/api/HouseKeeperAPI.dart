import 'package:get/get.dart';
import 'package:housekeeper/brain/data/models/keepers.dart';
import 'package:housekeeper/brain/helpers/dio.dart';

class HouseKeeperAPI extends GetxService {
  HouseKeeperAPI();
  static final HttpUtil http = HttpUtil();

  static Future<List<KeeperModel>> topKeepers() {
    String URL = 'keepers/top/search';
    return http.get(URL).then((response) {
      List<KeeperModel> keepers = [];
      var data = response['data'];
      if (response['status_code'] == 200) {
        List collected = data['result'];
        for (int i = 0; i < collected.length; i++) {
          keepers.add(KeeperModel.fromJSON(collected[i]));
        }
      }
      return keepers;
    });
  }

  static Future<List<KeeperModel>> nearKeepers() {
    String URL = 'keepers/near/search';
    return http.get(URL).then((response) {
      List<KeeperModel> keepers = [];
      var data = response['data'];
      if (response['status_code'] == 200) {
        List collected = data['result'];
        for (int i = 0; i < collected.length; i++) {
          keepers.add(KeeperModel.fromJSON(collected[i]));
        }
      }
      return keepers;
    });
  }

  static Future<List<KeeperModel>> searchData({String? searchTerm, List<String>? filter}) {
    String URL = 'keepers/keeper/search';
    Map<String, dynamic> queryParams = {
      'searchTerm': searchTerm,
      'filter': filter
    };
    return http.get(URL, queryParams: queryParams).then((response) {
      List<KeeperModel> keepers = [];
      var data = response['data'];
      if (response['status_code'] == 200) {
        List collected = data['result'];
        for (int i = 0; i < collected.length; i++) {
          keepers.add(KeeperModel.fromJSON(collected[i]));
        }
      }
      return keepers;
    });
  }
}
