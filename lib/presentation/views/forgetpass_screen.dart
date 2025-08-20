import 'package:capstone/core/routes/app_routes.dart';
import 'package:capstone/shared/constants/app_colors.dart';
import 'package:capstone/shared/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:capstone/domain/viewmodels/auth_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Responsive.padding(4)),
          child: Column(
            children: [
              SizedBox(height: Responsive.height(4)),

              Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () {
                    Get.offNamed(AppRoutes.login);
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColors.lightgrey,
                    radius: Responsive.radius(7),
                    child: FaIcon(
                      FontAwesomeIcons.angleLeft,
                      color: AppColors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Responsive.height(16)),
              Center(
                child: Text(
                  "Forget Password",
                  style: TextStyle(
                    fontSize: Responsive.fontSize(7),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              SizedBox(height: Responsive.height(2)),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(Responsive.padding(3)),
                  child: Text(
                    "Enter your email address to receive a password reset link.",
                    style: TextStyle(
                      fontSize: Responsive.fontSize(3.5),
                      fontFamily: "poppins",
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: Responsive.height(3)),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email, color: AppColors.grey),
                  hintText: "Email",
                  hintStyle: TextStyle(
                    fontFamily: 'Poppins',
                    color: AppColors.grey,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: Responsive.screenWidth * 0.08,
                    vertical: Responsive.screenHeight * 0.02,
                  ),

                  filled: true,
                  fillColor: AppColors.lightgrey,

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: AppColors.bordergrey,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.red, width: 2),
                  ),
                ),
              ),
              SizedBox(height: Responsive.height(4)),
              Obx(
                () => Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.gradientStart,
                            AppColors.gradientEnd,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(
                          Responsive.radius(30),
                        ),
                      ),

                      width: Responsive.width(50),
                      height: Responsive.height(7),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (!authController.isLoading.value) {
                            final email = emailController.text.trim();
                            if (email.isNotEmpty) {
                              authController.isLoading.value = true;

                              await Future.delayed(const Duration(seconds: 2));

                              authController.resetPassword(email);

                              authController.isLoading.value = false;
                            } else {
                              Get.snackbar(
                                "Error",
                                "Please enter an email",
                                backgroundColor: AppColors.errorColor,
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              Responsive.radius(30),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: Responsive.padding(15),
                            vertical: Responsive.padding(2),
                          ),
                        ),
                        child: Obx(
                          () => authController.isLoading.value
                              ? const SizedBox.shrink()
                              : const Text(
                                  "Reset",
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                        ),
                      ),
                    ),
                    if (authController.isLoading.value)
                      const CircularProgressIndicator(color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
