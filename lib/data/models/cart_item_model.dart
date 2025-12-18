import 'product_model.dart';
import 'service_model.dart';

enum CartItemType { product, service }

class CartItemModel {
  final String id;
  final CartItemType type;
  final ProductModel? product;
  final ServiceModel? service;
  int quantity;

  CartItemModel({
    required this.id,
    required this.type,
    this.product,
    this.service,
    this.quantity = 1,
  });

  String get name => type == CartItemType.product 
      ? product?.name ?? '' 
      : service?.name ?? '';
  
  double get price => type == CartItemType.product 
      ? product?.price ?? 0 
      : service?.price ?? 0;
  
  double get total => price * quantity;
  
  String get formattedPrice => '${price.toStringAsFixed(0)} ກີບ';
  
  String get formattedTotal => '${total.toStringAsFixed(0)} ກີບ';
  
  String? get image => type == CartItemType.product 
      ? product?.firstImage 
      : null;

  Map<String, dynamic> toJson() {
    return {
      'type': type == CartItemType.product ? 'product' : 'service',
      'productId': product?.id,
      'serviceId': service?.id,
      'quantity': quantity,
      'price': price,
      'total': total,
    };
  }
}

