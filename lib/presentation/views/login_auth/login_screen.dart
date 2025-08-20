import 'package:capstone/core/routes/app_routes.dart';
import 'package:capstone/data/services/notification_service.dart';
import 'package:capstone/domain/viewmodels/auth_controller.dart';
import 'package:capstone/domain/viewmodels/google_controller.dart';
import 'package:capstone/shared/constants/app_colors.dart';
import 'package:capstone/shared/constants/app_images.dart';
import 'package:capstone/shared/utils/responsive_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final authController = Get.find<AuthController>();
  final GoogleAuthController controller = Get.find<GoogleAuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: Responsive.height(25)),
                Text(
                  "Let's  Login",
                  style: TextStyle(
                    fontSize: Responsive.fontSize(7),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: Responsive.height(5)),
                TextFormField(
                  controller: _emailController,
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
                  validator: (v) =>
                      !GetUtils.isEmail(v!) ? "Enter valid email" : null,
                ),
                SizedBox(height: Responsive.height(2)),
                Obx(
                  () => TextFormField(
                    controller: _passwordController,

                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: AppColors.grey),
                      hintText: "Password",
                      filled: true,
                      fillColor: AppColors.lightgrey,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: Responsive.screenWidth * 0.08,
                        vertical: Responsive.screenHeight * 0.02,
                      ),
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        color: AppColors.grey,
                      ),
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

                      suffixIcon: IconButton(
                        icon: Icon(
                          authController.isPasswordHidden.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.grey,
                        ),
                        onPressed: () {
                          authController.togglePasswordVisibility();
                        },
                      ),
                    ),
                    obscureText: authController.isPasswordHidden.value,
                    validator: (v) => v!.length < 6
                        ? "Password must be at least 6 chars"
                        : null,
                  ),
                ),
                SizedBox(height: Responsive.height(2)),
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.forgetPassword);
                    },
                    child: Text(
                      "Forget Password?",
                      style: TextStyle(
                        fontFamily: "poppins",
                        color: AppColors.black,
                        fontSize: Responsive.fontSize(3.5),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: Responsive.height(3)),
                Obx(
                  () => SizedBox(
                    width: Responsive.width(60),
                    height: Responsive.height(7),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
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
                          width: double.infinity,
                          height: double.infinity,
                          child: ElevatedButton(
                            onPressed: authController.isLoading.value
                                ? null
                                : () async {
                                    if (_formKey.currentState!.validate()) {
                                      authController.isLoading.value = true;

                                      await Future.delayed(
                                        const Duration(seconds: 2),
                                      );

                                      bool success = await authController.login(
                                        _emailController.text.trim(),
                                        _passwordController.text.trim(),
                                      );

                                      await AppNotificationService.saveDeviceToken();

                                      authController.isLoading.value = false;

                                      if (success) {
                                        Get.offAllNamed(AppRoutes.home);
                                      } else {
                                        Get.snackbar("Error", "Login failed");
                                      }
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  Responsive.radius(30),
                                ),
                              ),
                            ),
                            child: authController.isLoading.value
                                ? const SizedBox.shrink() // Text hide loader ke waqt
                                : const Text(
                                    "Login",
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                          ),
                        ),

                        // Loader
                        if (authController.isLoading.value)
                          const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: Responsive.height(2.5)),
                RichText(
                  text: TextSpan(
                    text: "Don't have an account ? ",
                    style: TextStyle(
                      fontSize: Responsive.fontSize(3.5),
                      fontFamily: 'Poppins',
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: "Signup",
                        style: TextStyle(
                          fontSize: Responsive.fontSize(3.5),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed(AppRoutes.signup);
                          },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: Responsive.height(4)),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Google Icon Button
                    ElevatedButton(
                      onPressed: () async {
                        authController.isLoading.value = true;
                        await controller.signInWithGoogle();
                        authController.isLoading.value = false;

                        if (controller.user.value != null) {
                          await AppNotificationService.saveDeviceToken();
                          Get.offAllNamed(AppRoutes.home);
                        } else {
                          Get.snackbar("Error", "Google Sign-In failed");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.lightgrey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            Responsive.radius(30),
                          ),
                        ),
                        elevation: 5,
                        padding: EdgeInsets.all(Responsive.padding(5)),
                        shadowColor: AppColors.black,
                      ),
                      child: SvgPicture.asset(
                        AppImages.google,
                        height: Responsive.height(3.5),
                        width: Responsive.width(3.5),
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        // Facebook sign-in logic here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.lightgrey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            Responsive.radius(30),
                          ),
                        ),
                        elevation: 5,
                        padding: EdgeInsets.all(Responsive.padding(5)),
                        shadowColor: AppColors.black,
                      ),

                      child: SvgPicture.asset(
                        AppImages.apple,
                        height: Responsive.height(3.5),
                        width: Responsive.width(3.5),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Facebook sign-in logic here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.lightgrey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            Responsive.radius(30),
                          ),
                        ),
                        elevation: 5,
                        padding: EdgeInsets.all(Responsive.padding(5)),
                        shadowColor: AppColors.black,
                      ),

                      child: SvgPicture.asset(
                        AppImages.facebook,
                        height: Responsive.height(3.5),
                        width: Responsive.width(3.5),
                      ),
                    ),
                  ],
                ),

                // Center(
                //   child: Obx(() {
                //     if (controller.isLoading.value) {
                //       return CircularProgressIndicator();
                //     }

                //     if (controller.user.value != null) {
                //       return Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           CircleAvatar(
                //             backgroundImage: NetworkImage(
                //               controller.user.value!.photoURL ?? "",
                //             ),
                //             radius: 40,
                //           ),
                //           SizedBox(height: 10),
                //           Text(
                //             "Welcome, ${controller.user.value!.displayName}",
                //           ),
                //           SizedBox(height: 20),
                //           ElevatedButton(
                //             onPressed: controller.signOut,
                //             child: Text("Logout"),
                //           ),
                //         ],
                //       );
                //     }

                //     return ElevatedButton.icon(
                //       onPressed: controller.signInWithGoogle,
                //       icon: Icon(Icons.login),
                //       label: Text("Sign in with Google"),
                //     );
                //   }),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
