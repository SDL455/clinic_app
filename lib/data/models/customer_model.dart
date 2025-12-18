class CustomerModel {
  final String id;
  final String firstName;
  final String lastName;
  final String phone;
  final int? age;
  final String? province;
  final String? district;
  final String? village;
  final String? image;

  CustomerModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    this.age,
    this.province,
    this.district,
    this.village,
    this.image,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      phone: json['phone'] ?? '',
      age: json['age'],
      province: json['province'],
      district: json['district'],
      village: json['village'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'age': age,
      'province': province,
      'district': district,
      'village': village,
      'image': image,
    };
  }

  String get fullName => '$firstName $lastName';
  
  String get address {
    final parts = <String>[];
    if (village != null && village!.isNotEmpty) parts.add('ບ້ານ $village');
    if (district != null && district!.isNotEmpty) parts.add('ເມືອງ $district');
    if (province != null && province!.isNotEmpty) parts.add(province!);
    return parts.join(', ');
  }
}

