import '../models/service_model.dart';
import '../services/api_service.dart';
import '../../core/config/api_config.dart';

class ServiceRepository {
  final ApiService _apiService;

  ServiceRepository(this._apiService);

  Future<List<ServiceModel>> getServices() async {
    try {
      final response = await _apiService.get(ApiConfig.services);

      if (response.data['success'] == true) {
        final List data = response.data['data'] ?? [];
        return data.map((json) => ServiceModel.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<ServiceModel?> getService(String id) async {
    try {
      final response = await _apiService.get('${ApiConfig.serviceDetail}/$id');

      if (response.data['success'] == true) {
        return ServiceModel.fromJson(response.data['data']);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}

