import 'package:capstone/core/routes/app_routes.dart';
import 'package:capstone/shared/utils/local_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateUser();
  }

  void _navigateUser() async {
    await Future.delayed(const Duration(seconds: 3)); 
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      bool isFirstTime = !(await LocalStorage.getOnboardingSeen());

      if (isFirstTime) {
        Get.offAllNamed(AppRoutes.onBoarding);
      } else {
        Get.offAllNamed(AppRoutes.login);
      }
    }
  }
}
