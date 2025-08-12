import 'dart:io';

import 'package:capstone/model/cloudinary/cloudinary_api.dart';
import 'package:dio/dio.dart';

class CloudinaryService {
  final CloudinaryApi api;

  CloudinaryService(Dio dio)
      : api = CloudinaryApi(dio);

  Future<String?> uploadAvatar(File imageFile) async {
    try {
      final file = await MultipartFile.fromFile(imageFile.path);

      final response = await api.uploadImage(file, "capstone");

      return response.secure_url;
    } catch (e) {
      print("Upload error: $e");
      return null;
    }
  }
}
