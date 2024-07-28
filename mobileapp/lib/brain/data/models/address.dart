import 'package:hive/hive.dart';
import 'package:housekeeper/brain/data/models/user.dart';

class AddressModel {
  int? id;
  String? country;
  String? province;
  String? city;
  String? street;
  String? fullAddress;
  String? postalCode;
  String? fax;
  String? fixedPhone;

  AddressModel({
    this.id,
    this.country,
    this.province,
    this.city,
    this.street,
    this.fullAddress,
    this.postalCode,
    this.fax,
    this.fixedPhone,
  });

  factory AddressModel.fromJSON(Map<String, dynamic> json) => AddressModel(
        id: json['id'],
        country: json['country'],
        province: json['province'],
        city: json['city'],
        street: json['street'],
        fullAddress: json['full_address'],
        postalCode: json['postal_code'],
        fax: json['fax'],
        fixedPhone: json['fixed_phone'],
      );

  Map<String, dynamic> toJSON() => {
        'id': id,
        'country': country,
        'province': province,
        'city': city,
        'street': street,
        'full_address': fullAddress,
        'postal_code': postalCode,
        'fax': fax,
        'fixed_phone': fixedPhone,
      };

  @override
  String toString() {
    return '======================[Instance of ORDER]=======================\n'
        '          ID: $id\n'
        '          Country: $country\n'
        '          Province: $province\n'
        '          City: $city\n'
        '          Street: $street\n'
        '          Address: $fullAddress\n'
        '          Postal Code: $postalCode\n'
        '          Fax: $fax\n'
        '============================----------=============================\n';
  }
}
