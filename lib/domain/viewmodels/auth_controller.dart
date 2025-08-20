import 'dart:io';
import 'package:capstone/core/routes/app_routes.dart';
import 'package:capstone/data/repositories/auth_repo.dart';
import 'package:capstone/data/services/cloudinary_service.dart';
import 'package:capstone/model/authmodel/auth_model.dart';
import 'package:capstone/shared/constants/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthRepository _repo;
  var isLoading = false.obs;
  var currentUser = Rxn<Auth>();
  var avatarFile = Rxn<File>();
  var isPasswordHidden = true.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
      Get.snackbar(
        "Success",
        "Account created successfully",
        backgroundColor: AppColors.successColor,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Get.snackbar(
          "Error",
          "This email is already registered",
          backgroundColor: AppColors.errorColor,
        );
      } else if (e.code == 'weak-password') {
        Get.snackbar(
          "Error",
          "Password is too weak",
          backgroundColor: AppColors.errorColor,
        );
      } else if (e.code == 'invalid-email') {
        Get.snackbar(
          "Error",
          "Invalid email format",
          backgroundColor: AppColors.errorColor,
        );
      } else {
        Get.snackbar(
          "Error",
          e.message ?? "An error occurred",
          backgroundColor: AppColors.errorColor,
        );
      }
      return false;
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
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
      Get.snackbar(
        "Success",
        "Login successful",
        backgroundColor: AppColors.successColor,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar(
          "Error",
          "No user found with this email",
          backgroundColor: AppColors.errorColor,
        );
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          "Error",
          "Incorrect password",
          backgroundColor: AppColors.errorColor,
        );
      } else {
        Get.snackbar(
          "Error",
          e.message ?? "An error occurred",
          backgroundColor: AppColors.errorColor,
        );
      }
      return false;
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong",
        backgroundColor: AppColors.errorColor,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  void setAvatar(File? file) {
    avatarFile.value = file;
  }

  Future<void> logout() async {
    await _repo.logout();
    Get.snackbar(
      "Logged Out",
      "You have successfully logged out.",
      backgroundColor: AppColors.successColor,
    );

    Get.offAllNamed(AppRoutes.login);
  }

  void resetPassword(String email) async {
    isLoading.value = true;
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (snapshot.docs.isEmpty) {
        Get.snackbar(
          "Error",
          "No user found with this email",
          backgroundColor: AppColors.errorColor,
        );
      } else {
        await _auth.sendPasswordResetEmail(email: email);
        Get.snackbar(
          "Success",
          "Password reset email sent",
          backgroundColor: AppColors.successColor,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: AppColors.errorColor,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
