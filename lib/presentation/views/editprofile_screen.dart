import 'package:capstone/data/repositories/editprofile_repo.dart';
import 'package:capstone/data/services/cloudinary_service.dart';
import 'package:capstone/data/services/editprofile_service.dart';
import 'package:capstone/domain/viewmodels/auth_controller.dart';
import 'package:capstone/domain/viewmodels/darkmode_controller.dart';
import 'package:capstone/domain/viewmodels/eidtprofile_controller.dart';
import 'package:capstone/presentation/views/change_password_screen.dart';
import 'package:capstone/presentation/widgets/appbar.dart';
import 'package:capstone/presentation/widgets/custom_drawer.dart';
import 'package:capstone/presentation/widgets/divider.dart';
import 'package:capstone/presentation/widgets/gradient_button.dart';
import 'package:capstone/presentation/widgets/info_tile.dart';
import 'package:capstone/presentation/widgets/input_field.dart';
import 'package:capstone/presentation/widgets/profile_header.dart';
import 'package:capstone/presentation/widgets/section_card.dart';
import 'package:capstone/presentation/widgets/settings_tile.dart';
import 'package:capstone/shared/constants/app_colors.dart';
import 'package:capstone/shared/utils/responsive_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController controller = Get.put(
    ProfileController(
      ProfileRepository(ProfileService(), CloudinaryService(Dio())),
    ),
  );
  final authController = Get.put(AuthController());
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = themeController.isDarkMode.value;

      return Scaffold(
        drawer: CustomDrawer(),

        backgroundColor: isDark
            ? const Color(0xFF121212)
            : const Color(0xFFF8F9FA),
        body: Column(
          children: [
            SizedBox(height: Responsive.height(3)),
            CustomAppBar(title: "Profile"),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(
                    child: Container(
                      padding: EdgeInsets.all(Responsive.width(8)),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.grey[850] : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: isDark
                                ? Colors.black.withOpacity(0.3)
                                : Colors.grey.withOpacity(0.1),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.gradientStart,
                            ),
                            strokeWidth: 3,
                          ),
                          SizedBox(height: Responsive.height(2)),
                          Text(
                            "Loading profile...",
                            style: TextStyle(
                              fontSize: Responsive.fontSize(4),
                              fontFamily: 'Poppins',
                              color: isDark ? Colors.white70 : Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final user = controller.currentUser.value;
                if (user == null) {
                  return Center(
                    child: Container(
                      padding: EdgeInsets.all(Responsive.width(8)),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.grey[850] : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: isDark
                                ? Colors.black.withOpacity(0.3)
                                : Colors.grey.withOpacity(0.1),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.person_off,
                            size: Responsive.fontSize(12),
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                          ),
                          SizedBox(height: Responsive.height(2)),
                          Text(
                            "No user found",
                            style: TextStyle(
                              fontSize: Responsive.fontSize(5),
                              fontFamily: 'Poppins',
                              color: isDark ? Colors.white70 : Colors.grey[600],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                nameCtrl.text = user.displayName;
                emailCtrl.text = user.email;

                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.width(5),
                    vertical: Responsive.height(2),
                  ),
                  child: Column(
                    children: [
                      profileHeader(isDark, user),

                      SizedBox(height: Responsive.height(3)),

                      sectionCard(
                        isDark: isDark,
                        title: "Personal Information",
                        icon: FontAwesomeIcons.user,
                        children: [
                          InputField(
                            label: "Full Name",
                            controller: nameCtrl,
                            isDark: isDark,
                            prefixIcon: Icons.person_outline,
                          ),
                          SizedBox(height: Responsive.height(2.5)),
                          InputField(
                            label: "Email Address",
                            controller: emailCtrl,
                            isDark: isDark,
                            prefixIcon: Icons.email_outlined,
                          ),
                        ],
                      ),

                      SizedBox(height: Responsive.height(3)),

                      sectionCard(
                        isDark: isDark,
                        title: "Account Settings",
                        icon: FontAwesomeIcons.gear,
                        children: [
                          settingTile(
                            isDark: isDark,
                            title: "Change Password",
                            subtitle: "Update your account password",
                            icon: FontAwesomeIcons.lock,
                            onTap: () => Get.to(() => ChangePasswordScreen()),
                          ),
                          divider(isDark),
                          settingTile(
                            isDark: isDark,
                            title: "Dark Mode",
                            subtitle: "Toggle dark/light theme",
                            icon: FontAwesomeIcons.moon,
                            trailing: Switch(
                              value: isDark,
                              onChanged: (value) =>
                                  themeController.toggleTheme(),
                              activeColor: AppColors.gradientStart,
                            ),
                          ),
                          divider(isDark),
                          settingTile(
                            isDark: isDark,
                            title: "Notifications",
                            subtitle: "Manage notification preferences",
                            icon: FontAwesomeIcons.bell,
                            onTap: () {},
                          ),
                        ],
                      ),

                      SizedBox(height: Responsive.height(3)),

                      sectionCard(
                        isDark: isDark,
                        title: "App Information",
                        icon: FontAwesomeIcons.circleInfo,
                        children: [
                          infoTile(
                            isDark: isDark,
                            title: "Version",
                            value: "1.0.0",
                            icon: FontAwesomeIcons.tag,
                          ),
                          divider(isDark),
                          infoTile(
                            isDark: isDark,
                            title: "Last Updated",
                            value: "Dec 2024",
                            icon: FontAwesomeIcons.calendar,
                          ),
                          divider(isDark),
                          settingTile(
                            isDark: isDark,
                            title: "Privacy Policy",
                            subtitle: "Read our privacy policy",
                            icon: FontAwesomeIcons.shield,
                            onTap: () {},
                          ),
                        ],
                      ),

                      SizedBox(height: Responsive.height(4)),

                      GradientButton(
                        label: "Save Changes",
                        onPressed: () => controller.updateProfile(
                          displayName: nameCtrl.text.trim(),
                          email: emailCtrl.text.trim(),
                        ),
                        isLoading: controller.isLoading,
                        gradient: LinearGradient(
                          colors: isDark
                              ? [
                                  AppColors.gradientStart.withOpacity(0.8),
                                  AppColors.gradientEnd.withOpacity(0.8),
                                ]
                              : [
                                  AppColors.gradientStart,
                                  AppColors.gradientEnd,
                                ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),

                      SizedBox(height: Responsive.height(2.5)),

                      GradientButton(
                        label: "Logout",
                        onPressed: () => _showLogoutDialog(context, isDark),
                        isLoading: controller.isLoading,
                        gradient: LinearGradient(
                          colors: isDark
                              ? [Colors.red.shade900, Colors.red.shade700]
                              : [
                                  Colors.redAccent.shade700,
                                  Colors.redAccent.shade400,
                                ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),

                      SizedBox(height: Responsive.height(4)),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      );
    });
  }

  void _showLogoutDialog(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: isDark ? Colors.grey[850] : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(Responsive.width(2)),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.logout,
                color: Colors.red,
                size: Responsive.fontSize(5),
              ),
            ),
            SizedBox(width: Responsive.width(3)),
            Text(
              'Logout',
              style: TextStyle(
                fontSize: Responsive.fontSize(5),
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black87,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
        content: Text(
          'Are you sure you want to logout from your account?',
          style: TextStyle(
            fontSize: Responsive.fontSize(4),
            color: isDark ? Colors.white70 : Colors.grey[600],
            fontFamily: 'Poppins',
          ),
        ),
        actions: [
          TextButton(
            child: Text(
              'Cancel',
              style: TextStyle(
                fontSize: Responsive.fontSize(4),
                color: isDark ? Colors.white70 : Colors.grey[600],
                fontFamily: 'Poppins',
              ),
            ),
            onPressed: () => Navigator.of(dialogContext).pop(),
          ),
          ElevatedButton(
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: Responsive.fontSize(4),
                color: Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Navigator.of(dialogContext).pop();
              authController.logout();
            },
          ),
        ],
      ),
    );
  }
}
