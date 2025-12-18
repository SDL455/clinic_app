class PromotionModel {
  final String id;
  final String name;
  final String? description;
  final double discount;
  final bool isPercent;
  final DateTime startDate;
  final DateTime endDate;
  final List<String>? images;

  PromotionModel({
    required this.id,
    required this.name,
    this.description,
    required this.discount,
    required this.isPercent,
    required this.startDate,
    required this.endDate,
    this.images,
  });

  factory PromotionModel.fromJson(Map<String, dynamic> json) {
    return PromotionModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      discount: (json['discount'] ?? 0).toDouble(),
      isPercent: json['isPercent'] ?? false,
      startDate: DateTime.parse(json['startDate'] ?? DateTime.now().toIso8601String()),
      endDate: DateTime.parse(json['endDate'] ?? DateTime.now().toIso8601String()),
      images: json['images'] != null 
          ? List<String>.from(json['images']) 
          : null,
    );
  }

  String get firstImage => images?.isNotEmpty == true ? images!.first : '';
  
  String get formattedDiscount => isPercent 
      ? '${discount.toStringAsFixed(0)}%' 
      : '${discount.toStringAsFixed(0)} ກີບ';
  
  bool get isActive {
    final now = DateTime.now();
    return now.isAfter(startDate) && now.isBefore(endDate);
  }
  
  int get daysLeft {
    final now = DateTime.now();
    return endDate.difference(now).inDays;
  }
}

