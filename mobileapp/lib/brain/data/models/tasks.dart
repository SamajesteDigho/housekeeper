import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class OrderModel {
  @HiveField(0)
  int? _id;
  String? ref;

  OrderModel({
    this.ref,
  });

  factory OrderModel.fromJSON(Map<String, dynamic> json) => OrderModel(
    ref: json['ref'],
  );

  Map<String, dynamic> toJSON() => {
    'ref': ref
  };

  @override
  String toString() {
    return '======================[Instance of ORDER]=======================\n'
        '          ID: $_id\n'
        '          REF: $ref'
        '============================----------=============================\n';
  }
}
