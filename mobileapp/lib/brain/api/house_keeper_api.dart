import 'package:get/get.dart';
import 'package:housekeeper/brain/data/models/keepers.dart';
import 'package:housekeeper/brain/helpers/dio.dart';

class HouseKeeperAPI extends GetxService {
  HouseKeeperAPI();
  static final HttpUtil http = HttpUtil();

  static Future<List<KeeperModel>> topKeepers() {
    String url = 'keepers/top/search';
    return http.get(url).then((response) {
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
    String url = 'keepers/near/search';
    return http.get(url).then((response) {
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
    String url = 'keepers/keeper/search';
    Map<String, dynamic> queryParams = {
      'searchTerm': searchTerm,
      'filter': filter
    };
    return http.get(url, queryParams: queryParams).then((response) {
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
