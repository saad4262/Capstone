import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'cloudinary_api.g.dart';

@RestApi(baseUrl: 'https://api.cloudinary.com/v1_1/du5viar25/image/upload')
abstract class CloudinaryApi {
  factory CloudinaryApi(Dio dio, {String baseUrl}) = _CloudinaryApi;

  @POST('')
  @MultiPart()
  Future<UploadResponse> uploadImage(
    @Part(name: 'file') MultipartFile file,
    @Part(name: 'upload_preset') String uploadPreset,
  );
}

class UploadResponse {
  final String secure_url;

  UploadResponse({required this.secure_url});

  factory UploadResponse.fromJson(Map<String, dynamic> json) {
    return UploadResponse(secure_url: json['secure_url']);
  }
}
