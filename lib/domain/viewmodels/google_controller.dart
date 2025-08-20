import 'package:get/get.dart';
import 'package:capstone/data/repositories/google_repo.dart';
import 'package:capstone/model/authmodel/auth_model.dart';

class GoogleAuthController extends GetxController {
  final GoogleAuthRepository _repository = GoogleAuthRepository();

  var isLoading = false.obs;
  var user = Rxn<Auth>();

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      final result = await _repository.signInWithGoogle();
      if (result != null) {
        user.value = result;
        Get.snackbar("Success", "Welcome ${result.displayName}");
      } else {
        Get.snackbar("Error", "Google Sign-In failed");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    await _repository.signOut();
    user.value = null;
    Get.snackbar("Signed Out", "You have been logged out");
  }
}
