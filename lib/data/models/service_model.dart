class ServiceModel {
  final String id;
  final String name;
  final String? description;
  final double price;

  ServiceModel({
    required this.id,
    required this.name,
    this.description,
    required this.price,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      price: (json['price'] ?? 0).toDouble(),
    );
  }

  String get formattedPrice => '${price.toStringAsFixed(0)} ກີບ';
}
