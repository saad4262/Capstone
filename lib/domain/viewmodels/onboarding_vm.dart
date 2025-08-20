import 'package:capstone/core/routes/app_routes.dart';
import 'package:capstone/shared/utils/local_storage.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  var pageIndex = 0.obs;

  void nextPage() async{
    if (pageIndex.value < 2) {
      pageIndex.value++;
    } else {
    await LocalStorage.setOnboardingSeen(true);

      Get.offNamed(AppRoutes.login);
    }
  }

  void skip() async{
        await LocalStorage.setOnboardingSeen(true);

    Get.offNamed(AppRoutes.login);
  }
}
