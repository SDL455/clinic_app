import 'package:get/get.dart';

import '../../data/services/api_service.dart';
import '../../data/repositories/product_repository.dart';
import '../../data/repositories/service_repository.dart';
import '../../data/repositories/promotion_repository.dart';
import '../../data/repositories/auth_repository.dart';
import '../../presentation/controllers/auth_controller.dart';
import '../../presentation/controllers/cart_controller.dart';
import '../../presentation/controllers/settings_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Services
    Get.put(ApiService(), permanent: true);

    // Repositories
    Get.lazyPut(() => ProductRepository(Get.find<ApiService>()));
    Get.lazyPut(() => ServiceRepository(Get.find<ApiService>()));
    Get.lazyPut(() => PromotionRepository(Get.find<ApiService>()));
    Get.lazyPut(() => AuthRepository(Get.find<ApiService>()));

    // Controllers
    Get.put(AuthController(), permanent: true);
    Get.put(CartController(), permanent: true);
    Get.put(SettingsController(), permanent: true);
  }
}
