import 'package:capstone/data/services/google_service.dart';
import 'package:capstone/model/authmodel/auth_model.dart';

class GoogleAuthRepository {
  final GoogleAuthService _service = GoogleAuthService();

  // Returns Auth? instead of User
  Future<Auth?> signInWithGoogle() => _service.signInWithGoogle();

  Future<void> signOut() => _service.signOut();
}
