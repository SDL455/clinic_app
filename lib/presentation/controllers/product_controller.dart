import 'package:get/get.dart';

import '../../data/models/product_model.dart';
import '../../data/repositories/product_repository.dart';
import '../../data/services/api_service.dart';

class ProductController extends GetxController {
  final RxList<ProductModel> products = <ProductModel>[].obs;
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final Rx<ProductModel?> selectedProduct = Rx<ProductModel?>(null);

  final RxBool isLoading = true.obs;
  final RxBool isLoadingMore = false.obs;
  final RxString error = ''.obs;
  final RxString searchQuery = ''.obs;
  final RxnString selectedCategoryId = RxnString();

  final RxInt currentPage = 1.obs;
  final RxBool hasMoreData = true.obs;
  final int _limit = 20;

  @override
  void onInit() {
    super.onInit();
    loadProducts();
    loadCategories();
  }

  Future<void> loadProducts({bool refresh = false}) async {
    if (refresh) {
      currentPage.value = 1;
      hasMoreData.value = true;
    }

    isLoading.value = true;
    error.value = '';

    try {
      final repo = ProductRepository(Get.find<ApiService>());
      final result = await repo.getProducts(
        page: currentPage.value,
        limit: _limit,
        search: searchQuery.value.isNotEmpty ? searchQuery.value : null,
        categoryId: selectedCategoryId.value,
      );

      if (refresh || currentPage.value == 1) {
        products.value = result;
      } else {
        products.addAll(result);
      }

      hasMoreData.value = result.length >= _limit;
    } catch (e) {
      error.value = 'ເກີດຂໍ້ຜິດພາດໃນການໂຫຼດສິນຄ້າ';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMore() async {
    if (isLoadingMore.value || !hasMoreData.value) return;

    isLoadingMore.value = true;
    currentPage.value++;

    try {
      final repo = ProductRepository(Get.find<ApiService>());
      final result = await repo.getProducts(
        page: currentPage.value,
        limit: _limit,
        search: searchQuery.value.isNotEmpty ? searchQuery.value : null,
        categoryId: selectedCategoryId.value,
      );

      products.addAll(result);
      hasMoreData.value = result.length >= _limit;
    } catch (e) {
      currentPage.value--;
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future<void> loadCategories() async {
    try {
      final repo = ProductRepository(Get.find<ApiService>());
      categories.value = await repo.getCategories();
    } catch (e) {
      // Handle error silently
    }
  }

  Future<void> loadProductDetail(String id) async {
    isLoading.value = true;
    error.value = '';

    try {
      final repo = ProductRepository(Get.find<ApiService>());
      selectedProduct.value = await repo.getProduct(id);
    } catch (e) {
      error.value = 'ບໍ່ສາມາດໂຫຼດລາຍລະອຽດສິນຄ້າໄດ້';
    } finally {
      isLoading.value = false;
    }
  }

  void search(String query) {
    searchQuery.value = query;
    loadProducts(refresh: true);
  }

  void filterByCategory(String? categoryId) {
    selectedCategoryId.value = categoryId;
    loadProducts(refresh: true);
  }

  void clearFilters() {
    searchQuery.value = '';
    selectedCategoryId.value = null;
    loadProducts(refresh: true);
  }
}
