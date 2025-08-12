import 'dart:io';

import 'package:capstone/data/repositories/auth_repo.dart';
import 'package:capstone/data/services/cloudinary_service.dart';
import 'package:capstone/model/authmodel/auth_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // final AuthRepository _repo = AuthRepository();
  final AuthRepository _repo;

  // AuthController() : _repo = AuthRepository(CloudinaryService(Dio()));
  var isLoading = false.obs;
  var currentUser = Rxn<Auth>();
  var avatarFile = Rxn<File>();
  var isPasswordHidden = true.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  AuthController({AuthRepository? repository})
    : _repo = repository ?? AuthRepository(CloudinaryService(Dio()));

  Future<bool> signUp(String email, String password, String name) async {
    isLoading.value = true;
    try {
      final user = await _repo.signUp(
        email,
        password,
        name,
        avatarFile: avatarFile.value,
      );
      currentUser.value = user;
      return true;
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> login(String email, String password) async {
    isLoading.value = true;
    try {
      final user = await _repo.login(email, password);
      currentUser.value = user;
      return true;
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  void setAvatar(File? file) {
    avatarFile.value = file;
  }
}
