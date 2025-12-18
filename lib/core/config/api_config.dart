class ApiConfig {
  // Base URL - change this to your production URL
  static const String baseUrl = 'http://localhost:3000';

  // Public API endpoints
  static const String products = '/api/public/products';
  static const String productDetail = '/api/public/products';
  static const String services = '/api/public/services';
  static const String serviceDetail = '/api/public/services';
  static const String categories = '/api/public/categories';
  static const String promotions = '/api/public/promotions';
  static const String contact = '/api/public/contact';
  static const String settings = '/api/public/settings';

  // Customer endpoints
  static const String register = '/api/public/customers/register';
  static const String login = '/api/public/customers/login';
  static const String profile = '/api/public/customers/me';
  static const String orders = '/api/public/customers/orders';

  // Timeout settings
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
