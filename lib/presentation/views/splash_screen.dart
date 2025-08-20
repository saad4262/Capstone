import 'package:capstone/domain/viewmodels/splash_vm.dart';
import 'package:capstone/shared/constants/app_colors.dart';
import 'package:capstone/shared/constants/app_images.dart';
import 'package:capstone/shared/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget { 
  SplashScreen({super.key});
  final controller = Get.find<SplashController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.gradientStart, AppColors.gradientEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: Responsive.height(11)),
              Image.asset(AppImages.logo, height: Responsive.height(70)),
              Lottie.asset(AppImages.loading, height: Responsive.height(13)),
            ],
          ),
        ),
      ),
    );
  }
}
