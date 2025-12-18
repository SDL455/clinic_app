class ClinicInfoModel {
  final String? name;
  final String? subtitle;
  final String? logo;

  ClinicInfoModel({this.name, this.subtitle, this.logo});

  factory ClinicInfoModel.fromJson(Map<String, dynamic> json) {
    return ClinicInfoModel(
      name: json['name'],
      subtitle: json['subtitle'],
      logo: json['logo'],
    );
  }
}

class ContactInfoModel {
  final String id;
  final List<String> phone;
  final String? email;
  final String? facebook;
  final String? line;
  final String? website;
  final String? address;
  final String? province;
  final String? district;
  final String? village;
  final Map<String, String> openingHours;
  final String? mapUrl;
  final String? description;

  ContactInfoModel({
    required this.id,
    required this.phone,
    this.email,
    this.facebook,
    this.line,
    this.website,
    this.address,
    this.province,
    this.district,
    this.village,
    required this.openingHours,
    this.mapUrl,
    this.description,
  });

  factory ContactInfoModel.fromJson(Map<String, dynamic> json) {
    return ContactInfoModel(
      id: json['id'] ?? '',
      phone: json['phone'] != null ? List<String>.from(json['phone']) : [],
      email: json['email'],
      facebook: json['facebook'],
      line: json['line'],
      website: json['website'],
      address: json['address'],
      province: json['province'],
      district: json['district'],
      village: json['village'],
      openingHours: json['openingHours'] != null
          ? Map<String, String>.from(json['openingHours'])
          : {},
      mapUrl: json['mapUrl'],
      description: json['description'],
    );
  }

  String get fullAddress {
    final parts = <String>[];
    if (address != null && address!.isNotEmpty) parts.add(address!);
    if (village != null && village!.isNotEmpty) parts.add('ບ້ານ $village');
    if (district != null && district!.isNotEmpty) parts.add('ເມືອງ $district');
    if (province != null && province!.isNotEmpty) parts.add(province!);
    return parts.join(', ');
  }
}
