import 'package:capstone/domain/viewmodels/onboarding_vm.dart';
import 'package:get/get.dart';

class OnBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingController>(() => OnboardingController());
  }
}
