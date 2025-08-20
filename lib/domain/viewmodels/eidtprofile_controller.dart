import 'dart:io';
import 'package:capstone/data/repositories/editprofile_repo.dart';
import 'package:capstone/model/authmodel/auth_model.dart';
import 'package:capstone/shared/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final ProfileRepository _repo;

  var currentUser = Rxn<Auth>();
  var avatarFile = Rxn<File>();
  var isLoading = false.obs;

  ProfileController(this._repo);

  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }

  Future<void> fetchUser() async {
    isLoading.value = true;
    try {
      final user = await _repo.getCurrentUser();
      currentUser.value = user;
    } finally {
      isLoading.value = false;
    }
  }

  void setAvatar(File? file) {
    avatarFile.value = file;
  }

  Future<void> updateProfile({String? displayName, String? email}) async {
    if (currentUser.value == null) return;
    isLoading.value = true;
    try {
      await _repo.updateProfile(
        userId: currentUser.value!.userId,
        displayName: displayName,
        email: email,
        avatarFile: avatarFile.value,
      );
      await fetchUser();
    } finally {
      isLoading.value = false;
    }
  }

  final currentCtrl = TextEditingController();
  final newCtrl = TextEditingController();

  Future<void> updatePassword(
    String newPassword,
    String currentPassword,
  ) async {
    if (currentUser.value == null) return;

    if (currentPassword.isEmpty || newPassword.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill all fields",
        backgroundColor: AppColors.errorColor,
      );
      return;
    }

    if (newPassword.length < 6) {
      Get.snackbar(
        "Error",
        "New password must be at least 6 characters",
        backgroundColor: AppColors.errorColor,
      );
      return;
    }

    if (currentPassword == newPassword) {
      Get.snackbar(
        "Error",
        "New password cannot be same as current password",
        backgroundColor: AppColors.errorColor,
      );
      return;
    }

    try {
      isLoading.value = true;

      await Future.delayed(const Duration(seconds: 2));

      await _repo.updatePassword(newPassword, currentPassword);

      Get.snackbar(
        "Success",
        "Password updated successfully",
        backgroundColor: AppColors.successColor,
      );

      currentCtrl.clear();
      newCtrl.clear();
    } catch (e) {
      Get.snackbar(
        "Error",
        "Current password is incorrect",
        backgroundColor: AppColors.errorColor,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
