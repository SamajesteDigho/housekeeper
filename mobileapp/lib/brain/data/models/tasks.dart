import 'package:hive/hive.dart';
import 'package:housekeeper/brain/data/models/user.dart';

@HiveType(typeId: 1)
class TaskModel {
  @HiveField(0)
  int? id;
  String? ref;
  UserModel? client;
  UserModel? keeper;
  String? description;
  DateTime? start;
  DateTime? end;
  double? price_per_hour;
  String? currency;
  double? reduction;
  String? status;
  double? rating;
  String? appreciation;
  bool? paid;
  String? payment_ref;
  DateTime? created_at;
  DateTime? updated_at;

  TaskModel({
    this.id,
    this.ref,
    this.client,
    this.keeper,
    this.description,
    this.start,
    this.end,
    this.price_per_hour,
    this.currency,
    this.reduction,
    this.status,
    this.appreciation,
    this.paid,
    this.payment_ref,
    this.created_at,
    this.updated_at,
  });

  factory TaskModel.fromJSON(Map<String, dynamic> json) => TaskModel(
        id: json['id'],
        ref: json['ref'],
        client: UserModel.fromJSON(json['client']),
        keeper: UserModel.fromJSON(json['keeper']),
        description: json['description'],
        start: DateTime.tryParse(json['start']),
        end: DateTime.tryParse(json['end']),
        price_per_hour: double.tryParse('${json['price_per_hour']}'),
        currency: json['currency'],
        reduction: double.tryParse('${json['reduction']}'),
        status: json['status'],
        appreciation: json['appreciation'],
        paid: json['paid'],
        payment_ref: json['payment_ref'],
        created_at: DateTime.tryParse(json['created_at']),
        updated_at: DateTime.tryParse(json['updated_at']),
      );

  Map<String, dynamic> toJSON() => {};

  static List segmentTasks(List<TaskModel> tasks) {
    List<TaskModel> pr = [];
    List<TaskModel> og = [];
    List<TaskModel> cp = [];
    List<TaskModel> rf = [];
    for (int i = 0; i < tasks.length; i++) {
      if (['COMPLETED', 'PAID'].contains(tasks[i].status)) {
        cp.add(tasks[i]);
      } else if (['ACCEPTED', 'ONGOING'].contains(tasks[i].status)) {
        og.add(tasks[i]);
      } else if (['PENDING'].contains(tasks[i].status)) {
        pr.add(tasks[i]);
      } else {
        rf.add(tasks[i]);
      }
    }
    return [pr, og, cp, rf];
  }

  @override
  String toString() {
    return '======================[Instance of ORDER]=======================\n'
        '          ID: $id\n'
        '          REF: $ref\n'
        '          CLIENT: ${client?.firstname} ${client?.lastname}\n'
        '          KEEPER: ${keeper?.firstname} ${client?.lastname}\n'
        '          DESCRIPTION: $description\n'
        '          START: $start\n'
        '          END: $end\n'
        '          PRICE/H: $currency $price_per_hour\n'
        '          REDUCTION: $reduction\n'
        '          STATUS: $status\n'
        '          APPRECIATION: $appreciation\n'
        '          PAID: $paid\n'
        '          PAYMENT_REF: $payment_ref\n'
        '============================----------=============================\n';
  }
}
