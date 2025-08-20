import 'package:capstone/core/bindings/auth_binding.dart';
import 'package:capstone/core/bindings/home_binding.dart';
import 'package:capstone/core/bindings/onBarding_binding.dart';
import 'package:capstone/core/bindings/splash_bindings.dart';
import 'package:capstone/core/bindings/task_binding.dart';
import 'package:capstone/core/routes/app_routes.dart';
import 'package:capstone/presentation/views/dashboard_screen.dart';
import 'package:capstone/presentation/views/forgetpass_screen.dart';
import 'package:capstone/presentation/views/home.dart';
import 'package:capstone/presentation/views/login_auth/login_screen.dart';
import 'package:capstone/presentation/views/onboarding_screen.dart';
import 'package:capstone/presentation/views/signup_auth/signup_screen.dart';
import 'package:capstone/presentation/views/splash_screen.dart';
import 'package:capstone/presentation/views/task_screen.dart';
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
    GetPage(
      name: AppRoutes.login,
      page: () => LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => SignupView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.task,
      page: () => TaskScreen(),
      binding: TaskBinding(),
    ),
    GetPage(
      name: AppRoutes.forgetPassword,
      page: () => ForgotPasswordScreen(),
      binding: AuthBinding(),
    ),

    GetPage(
      name: AppRoutes.taskStats,
      page: () => DashboardScreen(),
      binding: TaskBinding(),
    ),

  ];
}
