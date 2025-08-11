import 'package:capstone/core/routes/app_routes.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  var pageIndex = 0.obs;

  void nextPage() {
    if (pageIndex.value < 2) {
      pageIndex.value++;
    } else {
      Get.offNamed(AppRoutes.home);
    }
  }

  void skip() {
    Get.offNamed(AppRoutes.home);
  }
}
