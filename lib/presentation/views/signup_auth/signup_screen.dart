import 'dart:io';

import 'package:capstone/core/routes/app_routes.dart';
import 'package:capstone/domain/viewmodels/auth_controller.dart';
import 'package:capstone/shared/constants/app_colors.dart';
import 'package:capstone/shared/constants/app_images.dart';
import 'package:capstone/shared/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final authController = Get.find<AuthController>();

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );
    if (picked != null) {
      authController.setAvatar(File(picked.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: Responsive.height(10)),
                Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: Responsive.fontSize(7),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: Responsive.height(5)),
                Obx(() {
                  final file = authController.avatarFile.value;
                  return GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: Responsive.radius(15),
                      backgroundColor: Colors.grey[300],
                      backgroundImage: file != null ? FileImage(file) : null,
                      child: file == null
                          ? const Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.white70,
                            )
                          : null,
                    ),
                  );
                }),
                SizedBox(height: Responsive.height(4)),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person, color: AppColors.grey),
                    hintText: "Name",
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
                      ), // darker grey border when focused
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
                  validator: (v) => v!.isEmpty ? "Enter your name" : null,
                ),
                SizedBox(height: Responsive.height(2)),

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
                SizedBox(height: Responsive.height(4)),
                Obx(
                  () => authController.isLoading.value
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: Responsive.width(60),
                          height: Responsive.height(7),
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final success = await authController.signUp(
                                  _emailController.text.trim(),
                                  _passwordController.text.trim(),
                                  _nameController.text.trim(),
                                );
                                if (success) {
                                  Get.offAllNamed(AppRoutes.task);
                                } else {
                                  Get.snackbar("Error", "Sign up failed");
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.blueMain,
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
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                color: AppColors.white,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                ),
                SizedBox(height: Responsive.height(1.8)),
                InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.login);
                  },
                  child: Text(
                    "Already have an account? Login",
                    style: TextStyle(
                      fontSize: Responsive.fontSize(3.5),
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),

                SizedBox(height: Responsive.height(3)),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Google Icon Button
                    ElevatedButton(
                      onPressed: () {
                        // Google sign-in logic here
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
