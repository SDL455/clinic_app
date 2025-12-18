import '../models/product_model.dart';
import '../services/api_service.dart';
import '../../core/config/api_config.dart';

class ProductRepository {
  final ApiService _apiService;

  ProductRepository(this._apiService);

  Future<List<ProductModel>> getProducts({
    int page = 1,
    int limit = 20,
    String? search,
    String? categoryId,
  }) async {
    try {
      final response = await _apiService.get(
        ApiConfig.products,
        queryParameters: {
          'page': page,
          'limit': limit,
          if (search != null && search.isNotEmpty) 'search': search,
          if (categoryId != null) 'categoryId': categoryId,
        },
      );

      if (response.data['success'] == true) {
        final List data = response.data['data'] ?? [];
        return data.map((json) => ProductModel.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<ProductModel?> getProduct(String id) async {
    try {
      final response = await _apiService.get('${ApiConfig.productDetail}/$id');

      if (response.data['success'] == true) {
        return ProductModel.fromJson(response.data['data']);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await _apiService.get(ApiConfig.categories);

      if (response.data['success'] == true) {
        final List data = response.data['data'] ?? [];
        return data.map((json) => CategoryModel.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }
}
