import 'package:hive/hive.dart';
import 'package:housekeeper/brain/data/models/user.dart';

class KeeperModel {
  int? id;
  String? matricule;
  double? rating;
  List<String>? images;
  String? nationality;
  String? province;
  String? religion;
  bool? verified;
  DateTime? createdAt;
  DateTime? updatedAt;

  KeeperModel({
    this.id,
    this.matricule,
    this.rating,
    this.images,
    this.nationality,
    this.province,
    this.religion,
    this.verified,
    this.createdAt,
    this.updatedAt,
  });

  factory KeeperModel.fromJSON(Map<String, dynamic> json) => KeeperModel(
        id: json['id'],
        matricule: json['matricule'],
        rating: double.tryParse('${json['rating']}'),
        images: json['images'],
        nationality: json['nationality'],
        religion: json['religion'],
        verified: json['verified'],
        createdAt: DateTime.tryParse(json['created_at'] ?? ''),
        updatedAt: DateTime.tryParse(json['updated_at'] ?? ''),
      );

  Map<String, dynamic> toJSON() => {
        'id': id,
        'matricule': matricule,
        'rating': rating,
        'images': images,
        'nationality': nationality,
        'province': province,
        'religion': religion,
        'verified': verified,
        'created_at': createdAt?.toString(),
        'updated_at': updatedAt?.toString(),
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
        '============================----------=============================\n';
  }
}
