import 'package:get/get.dart';

import '../../data/models/product_model.dart';
import '../../data/models/service_model.dart';
import '../../data/models/promotion_model.dart';
import '../../data/models/clinic_info_model.dart';
import '../../data/repositories/product_repository.dart';
import '../../data/repositories/service_repository.dart';
import '../../data/repositories/promotion_repository.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/services/api_service.dart';

class HomeController extends GetxController {
  final RxList<ProductModel> products = <ProductModel>[].obs;
  final RxList<ServiceModel> services = <ServiceModel>[].obs;
  final RxList<PromotionModel> promotions = <PromotionModel>[].obs;
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final Rx<ClinicInfoModel?> clinicInfo = Rx<ClinicInfoModel?>(null);
  final Rx<ContactInfoModel?> contactInfo = Rx<ContactInfoModel?>(null);

  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;
  final RxInt currentBannerIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    isLoading.value = true;
    error.value = '';

    try {
      final apiService = Get.find<ApiService>();

      await Future.wait([
        _loadProducts(apiService),
        _loadServices(apiService),
        _loadPromotions(apiService),
        _loadCategories(apiService),
        _loadClinicInfo(apiService),
        _loadContactInfo(apiService),
      ]);
    } catch (e) {
      error.value = 'ເກີດຂໍ້ຜິດພາດໃນການໂຫຼດຂໍ້ມູນ';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _loadProducts(ApiService apiService) async {
    try {
      final repo = ProductRepository(apiService);
      products.value = await repo.getProducts(limit: 10);
    } catch (e) {
      // Handle error silently
    }
  }

  Future<void> _loadServices(ApiService apiService) async {
    try {
      final repo = ServiceRepository(apiService);
      services.value = await repo.getServices();
    } catch (e) {
      // Handle error silently
    }
  }

  Future<void> _loadPromotions(ApiService apiService) async {
    try {
      final repo = PromotionRepository(apiService);
      promotions.value = await repo.getPromotions();
    } catch (e) {
      // Handle error silently
    }
  }

  Future<void> _loadCategories(ApiService apiService) async {
    try {
      final repo = ProductRepository(apiService);
      categories.value = await repo.getCategories();
    } catch (e) {
      // Handle error silently
    }
  }

  Future<void> _loadClinicInfo(ApiService apiService) async {
    try {
      final repo = AuthRepository(apiService);
      clinicInfo.value = await repo.getClinicInfo();
    } catch (e) {
      // Handle error silently
    }
  }

  Future<void> _loadContactInfo(ApiService apiService) async {
    try {
      final repo = AuthRepository(apiService);
      contactInfo.value = await repo.getContactInfo();
    } catch (e) {
      // Handle error silently
    }
  }

  void setBannerIndex(int index) {
    currentBannerIndex.value = index;
  }
}
