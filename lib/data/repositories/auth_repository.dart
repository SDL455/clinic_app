import '../models/customer_model.dart';
import '../models/clinic_info_model.dart';
import '../services/api_service.dart';
import '../../core/config/api_config.dart';

class AuthRepository {
  final ApiService _apiService;

  AuthRepository(this._apiService);

  Future<Map<String, dynamic>> register({
    required String firstName,
    required String lastName,
    required String phone,
    int? age,
    String? province,
    String? district,
    String? village,
  }) async {
    try {
      final response = await _apiService.post(
        ApiConfig.register,
        data: {
          'firstName': firstName,
          'lastName': lastName,
          'phone': phone,
          if (age != null) 'age': age,
          if (province != null) 'province': province,
          if (district != null) 'district': district,
          if (village != null) 'village': village,
        },
      );

      if (response.data['success'] == true) {
        return {
          'success': true,
          'customer': CustomerModel.fromJson(response.data['data']['customer']),
          'token': response.data['data']['token'],
        };
      }
      return {
        'success': false,
        'error': response.data['error'] ?? 'ເກີດຂໍ້ຜິດພາດ',
      };
    } catch (e) {
      return {
        'success': false,
        'error': e.toString().replaceAll('Exception: ', ''),
      };
    }
  }

  Future<Map<String, dynamic>> login(String phone) async {
    try {
      final response = await _apiService.post(
        ApiConfig.login,
        data: {'phone': phone},
      );

      if (response.data['success'] == true) {
        return {
          'success': true,
          'customer': CustomerModel.fromJson(response.data['data']['customer']),
          'token': response.data['data']['token'],
        };
      }
      return {
        'success': false,
        'error': response.data['error'] ?? 'ເກີດຂໍ້ຜິດພາດ',
      };
    } catch (e) {
      return {
        'success': false,
        'error': e.toString().replaceAll('Exception: ', ''),
      };
    }
  }

  Future<CustomerModel?> getProfile() async {
    try {
      final response = await _apiService.get(ApiConfig.profile);

      if (response.data['success'] == true) {
        return CustomerModel.fromJson(response.data['data']);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data) async {
    try {
      final response = await _apiService.put(ApiConfig.profile, data: data);

      if (response.data['success'] == true) {
        return {
          'success': true,
          'customer': CustomerModel.fromJson(response.data['data']),
        };
      }
      return {
        'success': false,
        'error': response.data['error'] ?? 'ເກີດຂໍ້ຜິດພາດ',
      };
    } catch (e) {
      return {
        'success': false,
        'error': e.toString().replaceAll('Exception: ', ''),
      };
    }
  }

  Future<ClinicInfoModel?> getClinicInfo() async {
    try {
      final response = await _apiService.get(ApiConfig.settings);

      if (response.data['success'] == true) {
        return ClinicInfoModel.fromJson(response.data['data']);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<ContactInfoModel?> getContactInfo() async {
    try {
      final response = await _apiService.get(ApiConfig.contact);

      if (response.data['success'] == true) {
        return ContactInfoModel.fromJson(response.data['data']);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
