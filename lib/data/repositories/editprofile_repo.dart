import 'dart:io';
import 'package:capstone/data/services/editprofile_service.dart';
import 'package:capstone/data/services/cloudinary_service.dart';
import 'package:capstone/model/authmodel/auth_model.dart';

class ProfileRepository {
  final ProfileService _service;
  final CloudinaryService _cloudinary;

  ProfileRepository(this._service, this._cloudinary);

  Future<Auth?> getCurrentUser() => _service.getCurrentUser();

  Future<void> updateProfile({
    required String userId,
  String? displayName,
    File? avatarFile,
    String? email,
    String? currentPassword,
  }) async {
    String? avatarUrl;
    if (avatarFile != null) {
      avatarUrl = await _cloudinary.uploadAvatar(avatarFile);
    }
    if (email != null && currentPassword != null) {
      await _service.updateAuthEmail(email, currentPassword);
    }

    await _service.updateProfile(
      userId: userId,
      displayName: displayName,
      avatarUrl: avatarUrl,
      email: email,
    );
  }


  Future<void> updatePassword(
    String newPassword,
    String currentPassword,
  ) async {
    await _service.updatePassword(newPassword, currentPassword);
  }
}
