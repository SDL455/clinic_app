import 'package:get/get.dart';

import '../../data/models/cart_item_model.dart';
import '../../data/models/product_model.dart';
import '../../data/models/service_model.dart';
import '../../data/models/promotion_model.dart';

class CartController extends GetxController {
  final RxList<CartItemModel> items = <CartItemModel>[].obs;
  final Rx<PromotionModel?> appliedPromotion = Rx<PromotionModel?>(null);

  double get subtotal => items.fold(0, (sum, item) => sum + item.total);
  
  double get discount {
    if (appliedPromotion.value == null) return 0;
    final promo = appliedPromotion.value!;
    if (promo.isPercent) {
      return subtotal * (promo.discount / 100);
    }
    return promo.discount;
  }
  
  double get total => subtotal - discount;
  
  int get itemCount => items.length;
  
  int get totalQuantity => items.fold(0, (sum, item) => sum + item.quantity);

  String get formattedSubtotal => '${subtotal.toStringAsFixed(0)} ກີບ';
  String get formattedDiscount => '${discount.toStringAsFixed(0)} ກີບ';
  String get formattedTotal => '${total.toStringAsFixed(0)} ກີບ';

  void addProduct(ProductModel product, {int quantity = 1}) {
    final existingIndex = items.indexWhere(
      (item) => item.type == CartItemType.product && item.product?.id == product.id
    );
    
    if (existingIndex != -1) {
      items[existingIndex].quantity += quantity;
      items.refresh();
    } else {
      items.add(CartItemModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: CartItemType.product,
        product: product,
        quantity: quantity,
      ));
    }
    
    Get.snackbar(
      'ເພີ່ມສຳເລັດ',
      '${product.name} ຖືກເພີ່ມໃສ່ກະຕ່າແລ້ວ',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  void addService(ServiceModel service, {int quantity = 1}) {
    final existingIndex = items.indexWhere(
      (item) => item.type == CartItemType.service && item.service?.id == service.id
    );
    
    if (existingIndex != -1) {
      items[existingIndex].quantity += quantity;
      items.refresh();
    } else {
      items.add(CartItemModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: CartItemType.service,
        service: service,
        quantity: quantity,
      ));
    }
    
    Get.snackbar(
      'ເພີ່ມສຳເລັດ',
      '${service.name} ຖືກເພີ່ມໃສ່ກະຕ່າແລ້ວ',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  void updateQuantity(int index, int quantity) {
    if (quantity <= 0) {
      removeItem(index);
    } else {
      items[index].quantity = quantity;
      items.refresh();
    }
  }

  void removeItem(int index) {
    items.removeAt(index);
  }

  void applyPromotion(PromotionModel promotion) {
    appliedPromotion.value = promotion;
    Get.snackbar(
      'ໃຊ້ໂປຣໂມຊັນສຳເລັດ',
      'ສ່ວນຫຼຸດ: ${promotion.formattedDiscount}',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  void removePromotion() {
    appliedPromotion.value = null;
  }

  void clearCart() {
    items.clear();
    appliedPromotion.value = null;
  }

  bool isProductInCart(String productId) {
    return items.any(
      (item) => item.type == CartItemType.product && item.product?.id == productId
    );
  }

  bool isServiceInCart(String serviceId) {
    return items.any(
      (item) => item.type == CartItemType.service && item.service?.id == serviceId
    );
  }
}

