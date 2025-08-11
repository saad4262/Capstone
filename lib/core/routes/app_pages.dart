import 'package:capstone/core/bindings/home_binding.dart';
import 'package:capstone/core/bindings/onBarding_binding.dart';
import 'package:capstone/core/bindings/splash_bindings.dart';
import 'package:capstone/core/routes/app_routes.dart';
import 'package:capstone/presentation/views/home.dart';
import 'package:capstone/presentation/views/onboarding_screen.dart';
import 'package:capstone/presentation/views/splash_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.onBoarding,
      page: () => OnboardingScreen(),
      binding: OnBoardBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
