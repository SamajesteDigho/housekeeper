import 'package:hive/hive.dart';
import 'package:housekeeper/brain/data/models/user.dart';

class KeeperModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  UserModel? user;
  @HiveField(2)
  String? matricule;
  @HiveField(3)
  double? rating;
  @HiveField(4)
  List<String>? images;
  @HiveField(5)
  String? nationality;
  @HiveField(6)
  String? province;
  @HiveField(7)
  String? religion;
  @HiveField(8)
  bool? verified;
  @HiveField(9)
  DateTime? created_at;
  @HiveField(10)
  DateTime? updated_at;

  KeeperModel({
    this.id,
    this.user,
    this.matricule,
    this.rating,
    this.images,
    this.nationality,
    this.province,
    this.religion,
    this.verified,
    this.created_at,
    this.updated_at,
  });

  factory KeeperModel.fromJSON(Map<String, dynamic> json) => KeeperModel(
        user: UserModel.fromJSON(json),
        id: json['keeper']['id'],
        matricule: json['keeper']['matricule'],
        rating: double.tryParse('${json['keeper']['rating']}'),
        images: json['keeper']['images'],
        nationality: json['keeper']['nationality'],
        religion: json['keeper']['religion'],
        verified: json['keeper']['verified'],
        created_at: DateTime.tryParse(json['keeper']['created_at'] ?? ''),
        updated_at: DateTime.tryParse(json['keeper']['updated_at'] ?? ''),
      );

  Map<String, dynamic> toJSON() => {
        'user': user?.toJSON(),
        'id': id,
        'matricule': matricule,
        'rating': rating,
        'images': images,
        'nationality': nationality,
        'province': province,
        'religion': religion,
        'verified': verified,
        'created_at': created_at?.toString(),
        'updated_at': updated_at?.toString(),
      };

  @override
  String toString() {
    return '======================[Instance of ORDER]=======================\n'
        '          ID: $id\n'
        '          MAT: $matricule\n'
        '          Rating: $rating\n'
        '          Nationality: $nationality\n'
        '          Province: $province\n'
        '          Religion: $religion\n'
        '          Verified: $verified\n'
        '          Name: ${user?.firstname} ${user?.lastname}\n'
        '============================----------=============================\n';
  }
}
