import 'package:hive/hive.dart';
import 'package:housekeeper/brain/data/models/address.dart';
import 'package:housekeeper/brain/data/models/keepers.dart';

class UserModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? ref;
  @HiveField(2)
  String? firstname;
  @HiveField(3)
  String? lastname;
  @HiveField(4)
  DateTime? birthdate;
  @HiveField(5)
  String? username;
  @HiveField(6)
  String? email;
  @HiveField(7)
  DateTime? emailVerifiedAt;
  @HiveField(8)
  String? phone;
  @HiveField(9)
  DateTime? phoneVerifiedAt;
  @HiveField(10)
  String? role;
  @HiveField(11)
  String? status;
  @HiveField(12)
  String? avatar;
  @HiveField(13)
  DateTime? createdAt;
  @HiveField(14)
  DateTime? updatedAt;
  KeeperModel? keeper;
  AddressModel? address;

  UserModel({
    this.id,
    this.ref,
    this.firstname,
    this.lastname,
    this.birthdate,
    this.username,
    this.email,
    this.emailVerifiedAt,
    this.phone,
    this.phoneVerifiedAt,
    this.role,
    this.status,
    this.avatar,
    this.createdAt,
    this.updatedAt,
    this.keeper,
    this.address,
  });

  factory UserModel.fromJSON(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        ref: json['ref'],
        firstname: json['firstname'],
        lastname: json['lastname'],
        birthdate: DateTime.tryParse(json['birthdate']),
        username: json['username'],
        email: json['email'],
        emailVerifiedAt: DateTime.tryParse(json['email_verified_at'] ?? ''),
        phone: json['phone'],
        phoneVerifiedAt: DateTime.tryParse(json['phone_verified_at'] ?? ''),
        role: json['role'],
        status: json['status'],
        avatar: json['avatar'],
        createdAt: DateTime.tryParse(json['created_at'] ?? ''),
        updatedAt: DateTime.tryParse(json['updated_at'] ?? ''),
        keeper: json['keeper'] == null ? null : KeeperModel.fromJSON(json['keeper']),
        address: json['address'] == null ? null : AddressModel.fromJSON(json['address']),
      );

  Map<String, dynamic> toJSON() => {
        'id': id,
        'ref': ref,
        'firstname': firstname,
        'lastname': lastname,
        'username': username,
        'birthdate': birthdate?.toString(),
        'email': email,
        'email_verified_at': emailVerifiedAt?.toString(),
        'phone': phone,
        'phone_verified_at': phoneVerifiedAt?.toString(),
        'role': role,
        'status': status,
        'avatar': avatar,
        'created_at': createdAt?.toString(),
        'updated_at': updatedAt?.toString(),
        'keeper': keeper?.toJSON(),
        'address': address?.toJSON(),
      };

  @override
  String toString() {
    return '======================[Instance of ORDER]=======================\n'
        '          ID: $id\n'
        '          REF: $ref\n'
        '          Name: $firstname $lastname\n'
        '          Birthdate: $birthdate\n'
        '          Username: $username\n'
        '          Email: $email\n'
        '          Phone: $phone\n'
        '          Role: $role\n'
        '          Status: $status\n'
        '============================----------=============================\n';
  }
}
