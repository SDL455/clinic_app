class ProductModel {
  final String id;
  final String name;
  final String? description;
  final double price;
  final List<String>? images;
  final int stock;
  final CategoryModel category;

  ProductModel({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    this.images,
    required this.stock,
    required this.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      price: (json['price'] ?? 0).toDouble(),
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      stock: json['stock'] ?? 0,
      category: CategoryModel.fromJson(json['category'] ?? {}),
    );
  }

  String get firstImage => images?.isNotEmpty == true ? images!.first : '';

  String get formattedPrice => '${price.toStringAsFixed(0)} ກີບ';

  bool get isInStock => stock > 0;
}

class CategoryModel {
  final String id;
  final String name;
  final String unit;
  final int? productCount;

  CategoryModel({
    required this.id,
    required this.name,
    required this.unit,
    this.productCount,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      unit: json['unit'] ?? '',
      productCount: json['productCount'],
    );
  }
}
