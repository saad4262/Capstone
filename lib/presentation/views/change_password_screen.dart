import 'package:capstone/domain/viewmodels/eidtprofile_controller.dart';
import 'package:capstone/presentation/widgets/gradient_button.dart';
import 'package:capstone/presentation/widgets/input_field.dart';
import 'package:capstone/shared/constants/app_colors.dart';
import 'package:capstone/shared/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});
  final ProfileController controller = Get.find();
  final currentCtrl = TextEditingController();
  final newCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bool isDark = Get.isDarkMode;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "Change Password",
          style: TextStyle(
            fontSize: Responsive.fontSize(5.5),
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [const Color(0xFF1E1E28), const Color(0xFF2D2D42)]
                : [const Color(0xFFF5F7FA), const Color(0xFFE4E8F0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.width(6),
              vertical: Responsive.height(3),
            ),
            child: Column(
              children: [
                InputField(
                  label: "Current Password",
                  controller: currentCtrl,
                  isDark: isDark,
                  isobsecure: true,
                ),
                SizedBox(height: Responsive.height(2.5)),
                InputField(
                  label: "New Password",
                  controller: newCtrl,
                  isDark: isDark,
                  isobsecure: true,
                ),
                SizedBox(height: Responsive.height(4)),
                GradientButton(
                  label: "Update Password",
                  onPressed: () => controller.updatePassword(
                    newCtrl.text.trim(),
                    currentCtrl.text.trim(),
                  ),
                  gradient: LinearGradient(
                    colors: isDark
                        ? [
                            const Color(0xFF0F0F17),
                            const Color(0xFF1C1C2E),
                          ] // dark shades
                        : [
                            AppColors.gradientStart,
                            AppColors.gradientEnd,
                          ], // light shades
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  isLoading: controller.isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
