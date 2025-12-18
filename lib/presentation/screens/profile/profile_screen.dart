import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/theme/app_theme.dart';
import '../../controllers/auth_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(() {
        if (!authController.isLoggedIn.value) {
          return _buildGuestView();
        }
        return _buildProfileView(authController);
      }),
    );
  }

  Widget _buildGuestView() {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Iconsax.user, size: 64, color: Colors.white),
              ),
              const SizedBox(height: 24),
              const Text(
                'ຍິນດີຕ້ອນຮັບ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'ເຂົ້າສູ່ລະບົບເພື່ອໃຊ້ງານເຕັມຮູບແບບ',
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.toNamed('/login'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'ເຂົ້າສູ່ລະບົບ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Get.toNamed('/register'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'ລົງທະບຽນ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileView(AuthController authController) {
    final customer = authController.customer.value!;

    return CustomScrollView(
      slivers: [
        // Header
        SliverAppBar(
          expandedHeight: 200,
          pinned: true,
          backgroundColor: AppColors.primary,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
              ),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Avatar
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                      child: customer.image != null
                          ? ClipOval(
                              child: Image.network(
                                customer.image!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Icon(
                              Iconsax.user,
                              size: 40,
                              color: AppColors.primary,
                            ),
                    ),
                    const SizedBox(height: 12),
                    // Name
                    Text(
                      customer.fullName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Phone
                    Text(
                      customer.phone,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Content
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Account section
                _buildSection(
                  title: 'ບັນຊີ',
                  children: [
                    _buildMenuItem(
                      icon: Iconsax.user_edit,
                      title: 'ແກ້ໄຂຂໍ້ມູນ',
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      icon: Iconsax.receipt,
                      title: 'ປະຫວັດການສັ່ງຊື້',
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      icon: Iconsax.heart,
                      title: 'ລາຍການທີ່ມັກ',
                      onTap: () {},
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Settings section
                _buildSection(
                  title: 'ການຕັ້ງຄ່າ',
                  children: [
                    _buildMenuItem(
                      icon: Iconsax.image,
                      title: 'ພື້ນຫຼັງໃບໜ້າ Login',
                      onTap: () => Get.toNamed('/settings/login-background'),
                    ),
                    _buildMenuItem(
                      icon: Iconsax.notification,
                      title: 'ການແຈ້ງເຕືອນ',
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      icon: Iconsax.language_square,
                      title: 'ພາສາ',
                      subtitle: 'ລາວ',
                      onTap: () {},
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Support section
                _buildSection(
                  title: 'ຊ່ວຍເຫຼືອ',
                  children: [
                    _buildMenuItem(
                      icon: Iconsax.call,
                      title: 'ຕິດຕໍ່ເຮົາ',
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      icon: Iconsax.info_circle,
                      title: 'ກ່ຽວກັບແອັບ',
                      onTap: () {},
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Logout button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => _showLogoutDialog(authController),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: AppColors.error),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Iconsax.logout, color: AppColors.error),
                        SizedBox(width: 8),
                        Text(
                          'ອອກຈາກລະບົບ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.error,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            )
          : null,
      trailing: const Icon(
        Iconsax.arrow_right_3,
        size: 16,
        color: AppColors.textLight,
      ),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(AuthController controller) {
    Get.dialog(
      AlertDialog(
        title: const Text('ອອກຈາກລະບົບ'),
        content: const Text('ທ່ານແນ່ໃຈບໍ່ວ່າຕ້ອງການອອກຈາກລະບົບ?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('ຍົກເລີກ')),
          ElevatedButton(
            onPressed: () {
              controller.logout();
              Get.back();
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('ອອກຈາກລະບົບ'),
          ),
        ],
      ),
    );
  }
}
