import 'dart:io';

import 'package:capstone/data/services/auth_service.dart';
import 'package:capstone/data/services/cloudinary_service.dart';
import 'package:capstone/model/authmodel/auth_model.dart';

class AuthRepository {
  final FirebaseAuthService _service = FirebaseAuthService();
  final CloudinaryService _cloudinaryService;

  AuthRepository(this._cloudinaryService);
  // Future<Auth?> signUp(String email, String password, String name) {
  //   return _service.signUp(email, password, name);
  // }

  Future<Auth?> signUp(
    String email,
    String password,
    String name, {
    File? avatarFile,
  }) async {
    String avatarUrl = '';

    if (avatarFile != null) {
      final uploadedUrl = await _cloudinaryService.uploadAvatar(avatarFile);
      if (uploadedUrl != null) {
        avatarUrl = uploadedUrl;
      }
    }

    return _service.signUp(email, password, name, avatarUrl: avatarUrl);
  }

  Future<Auth?> login(String email, String password) {
    return _service.login(email, password);
  }
}
