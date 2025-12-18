import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/models/customer_model.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/services/api_service.dart';

class AuthController extends GetxController {
  final _storage = GetStorage();

  final Rx<CustomerModel?> customer = Rx<CustomerModel?>(null);
  final RxBool isLoading = false.obs;
  final RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadCustomer();
  }

  void _loadCustomer() {
    final customerData = _storage.read('customer');
    if (customerData != null) {
      customer.value = CustomerModel.fromJson(
        Map<String, dynamic>.from(customerData),
      );
      isLoggedIn.value = true;
    }
  }

  Future<Map<String, dynamic>> login(String phone) async {
    isLoading.value = true;
    try {
      final repo = AuthRepository(Get.find<ApiService>());
      final result = await repo.login(phone);

      if (result['success'] == true) {
        customer.value = result['customer'] as CustomerModel;
        isLoggedIn.value = true;

        // Save to storage
        Get.find<ApiService>().saveToken(result['token']);
        _storage.write('customer', customer.value!.toJson());

        return {'success': true};
      }
      return result;
    } finally {
      isLoading.value = false;
    }
  }

  Future<Map<String, dynamic>> register({
    required String firstName,
    required String lastName,
    required String phone,
    int? age,
    String? province,
    String? district,
    String? village,
  }) async {
    isLoading.value = true;
    try {
      final repo = AuthRepository(Get.find<ApiService>());
      final result = await repo.register(
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        age: age,
        province: province,
        district: district,
        village: village,
      );

      if (result['success'] == true) {
        customer.value = result['customer'] as CustomerModel;
        isLoggedIn.value = true;

        // Save to storage
        Get.find<ApiService>().saveToken(result['token']);
        _storage.write('customer', customer.value!.toJson());

        return {'success': true};
      }
      return result;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshProfile() async {
    try {
      final repo = AuthRepository(Get.find<ApiService>());
      final profile = await repo.getProfile();
      if (profile != null) {
        customer.value = profile;
        _storage.write('customer', customer.value!.toJson());
      }
    } catch (e) {
      // Handle error silently
    }
  }

  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data) async {
    isLoading.value = true;
    try {
      final repo = AuthRepository(Get.find<ApiService>());
      final result = await repo.updateProfile(data);

      if (result['success'] == true) {
        customer.value = result['customer'] as CustomerModel;
        _storage.write('customer', customer.value!.toJson());
        return {'success': true};
      }
      return result;
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    customer.value = null;
    isLoggedIn.value = false;
    Get.find<ApiService>().removeToken();
    _storage.remove('customer');
    _storage.remove('customer_token');
  }
}
