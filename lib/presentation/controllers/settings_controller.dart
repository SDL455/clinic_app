import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';

class SettingsController extends GetxController {
  final _storage = GetStorage();

  final RxnString loginBackgroundImagePath = RxnString();
  final RxDouble loginBackgroundOpacity = 0.5.obs;
  final RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
  }

  void _loadSettings() {
    loginBackgroundImagePath.value = _storage.read('login_bg_path');
    loginBackgroundOpacity.value = _storage.read('login_bg_opacity') ?? 0.5;
    isDarkMode.value = _storage.read('dark_mode') ?? false;
  }

  Future<void> setLoginBackground(String imagePath) async {
    try {
      // Copy image to app documents directory
      final directory = await getApplicationDocumentsDirectory();
      final fileName = 'login_bg_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final newPath = '${directory.path}/$fileName';

      // Delete old image if exists
      if (loginBackgroundImagePath.value != null) {
        final oldFile = File(loginBackgroundImagePath.value!);
        if (await oldFile.exists()) {
          await oldFile.delete();
        }
      }

      // Copy new image
      final originalFile = File(imagePath);
      await originalFile.copy(newPath);

      loginBackgroundImagePath.value = newPath;
      await _storage.write('login_bg_path', newPath);

      Get.snackbar(
        'ສຳເລັດ',
        'ຕັ້ງຄ່າພື້ນຫຼັງສຳເລັດແລ້ວ',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'ຜິດພາດ',
        'ບໍ່ສາມາດຕັ້ງຄ່າພື້ນຫຼັງໄດ້',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> removeLoginBackground() async {
    try {
      if (loginBackgroundImagePath.value != null) {
        final file = File(loginBackgroundImagePath.value!);
        if (await file.exists()) {
          await file.delete();
        }
      }

      loginBackgroundImagePath.value = null;
      await _storage.remove('login_bg_path');

      Get.snackbar(
        'ສຳເລັດ',
        'ລຶບພື້ນຫຼັງສຳເລັດແລ້ວ',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'ຜິດພາດ',
        'ບໍ່ສາມາດລຶບພື້ນຫຼັງໄດ້',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void setBackgroundOpacity(double opacity) {
    loginBackgroundOpacity.value = opacity;
    _storage.write('login_bg_opacity', opacity);
  }

  void toggleDarkMode() {
    isDarkMode.value = !isDarkMode.value;
    _storage.write('dark_mode', isDarkMode.value);
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}
