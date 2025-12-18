import 'package:get/get.dart';

import '../presentation/screens/main/main_screen.dart';
import '../presentation/screens/auth/login_screen.dart';
import '../presentation/screens/auth/register_screen.dart';
import '../presentation/screens/products/product_detail_screen.dart';
import '../presentation/screens/cart/cart_screen.dart';
import '../presentation/screens/profile/settings/login_background_settings_screen.dart';
import '../presentation/controllers/home_controller.dart';
import '../presentation/controllers/product_controller.dart';

class AppPages {
  static const initial = '/';

  static final routes = [
    GetPage(
      name: '/',
      page: () => const MainScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => HomeController());
      }),
    ),
    GetPage(name: '/login', page: () => const LoginScreen()),
    GetPage(name: '/register', page: () => const RegisterScreen()),
    GetPage(
      name: '/product/:id',
      page: () => const ProductDetailScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ProductController());
      }),
    ),
    GetPage(name: '/cart', page: () => const CartScreen()),
    GetPage(
      name: '/settings/login-background',
      page: () => const LoginBackgroundSettingsScreen(),
    ),
  ];
}
