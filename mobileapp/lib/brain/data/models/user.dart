import 'package:hive/hive.dart';

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
  DateTime? email_verified_at;
  @HiveField(8)
  String? phone;
  @HiveField(9)
  DateTime? phone_verified_at;
  @HiveField(10)
  String? role;
  @HiveField(11)
  String? status;
  @HiveField(12)
  String? avatar;
  @HiveField(13)
  DateTime? created_at;
  @HiveField(14)
  DateTime? updated_at;

  UserModel({
    this.id,
    this.ref,
    this.firstname,
    this.lastname,
    this.birthdate,
    this.username,
    this.email,
    this.email_verified_at,
    this.phone,
    this.phone_verified_at,
    this.role,
    this.status,
    this.avatar,
    this.created_at,
    this.updated_at,
  });

  factory UserModel.fromJSON(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        ref: json['ref'],
        firstname: json['firstname'],
        lastname: json['lastname'],
        birthdate: DateTime.tryParse(json['birthdate']),
        username: json['username'],
        email: json['email'],
        email_verified_at: DateTime.tryParse(json['email_verified_at'] ?? ''),
        phone: json['phone'],
        phone_verified_at: DateTime.tryParse(json['phone_verified_at'] ?? ''),
        role: json['role'],
        status: json['status'],
        avatar: json['avatar'],
        created_at: DateTime.tryParse(json['created_at'] ?? ''),
        updated_at: DateTime.tryParse(json['updated_at'] ?? ''),
      );

  Map<String, dynamic> toJSON() => {
        'id': id,
        'ref': ref,
        'firstname': firstname,
        'lastname': lastname,
        'username': username,
        'birthdate': birthdate?.toString(),
        'username': username,
        'email': email,
        'email_verified_at': email_verified_at?.toString(),
        'phone': phone,
        'phone_verified_at': phone_verified_at?.toString(),
        'role': role,
        'status': status,
        'avatar': avatar,
        'created_at': created_at?.toString(),
        'updated_at': updated_at?.toString(),
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
