import '../models/promotion_model.dart';
import '../services/api_service.dart';
import '../../core/config/api_config.dart';

class PromotionRepository {
  final ApiService _apiService;

  PromotionRepository(this._apiService);

  Future<List<PromotionModel>> getPromotions() async {
    try {
      final response = await _apiService.get(ApiConfig.promotions);

      if (response.data['success'] == true) {
        final List data = response.data['data'] ?? [];
        return data.map((json) => PromotionModel.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }
}
