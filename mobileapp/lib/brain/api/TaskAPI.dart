import 'package:get/get.dart';
import 'package:housekeeper/brain/data/models/keepers.dart';
import 'package:housekeeper/brain/data/models/orders.dart';
import 'package:housekeeper/brain/helpers/dio.dart';

class OrderAPI extends GetxService {
  OrderAPI();
  static final HttpUtil http = HttpUtil();

  static Future<List<OrderModel>> searchData({String? searchTerm, List<String>? filter}) {
    String URL = 'keepers/keeper/search';
    Map<String, dynamic> queryParams = {
      'searchTerm': searchTerm,
      'filter': filter
    };
    return http.get(URL, queryParams: queryParams).then((response) {
      List<OrderModel> orders = [];
      var data = response['data'];
      if (response['status_code'] == 200) {
        List collected = data['result'];
        for (int i = 0; i < collected.length; i++) {
          orders.add(OrderModel.fromJSON(collected[i]));
        }
      }
      return orders;
    });
  }
}
