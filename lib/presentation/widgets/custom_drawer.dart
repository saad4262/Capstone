import 'package:capstone/domain/viewmodels/auth_controller.dart';
import 'package:capstone/domain/viewmodels/user_controller.dart';
import 'package:capstone/shared/constants/app_colors.dart';
import 'package:capstone/shared/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({Key? key}) : super(key: key);
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final user = FirebaseAuth.instance.currentUser;
    final UserController controller = Get.put(UserController());

    return Drawer(
      backgroundColor: isDark ? const Color(0xFF0F0F0F) : Colors.white,
      child: Column(
        children: [
          Container(
            height: Responsive.height(35),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.gradientStart, AppColors.gradientEnd],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(Responsive.width(6)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Responsive.height(2)),

                        Container(
                          width: Responsive.width(20),
                          height: Responsive.width(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 3,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                controller.photoUrl.value.isNotEmpty
                                ? NetworkImage(controller.photoUrl.value)
                                : AssetImage("assets/images/default_avatar.png")
                                      as ImageProvider,
                          ),
                        ),

                        SizedBox(height: Responsive.height(2)),
                        Text(
                          controller.name.value.isNotEmpty
                              ? controller.name.value
                              : "User",
                          style: TextStyle(
                            fontSize: Responsive.fontSize(6),
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            fontFamily: 'Poppins',
                          ),
                        ),

                        SizedBox(height: Responsive.height(0.5)),

                        Text(
                          user?.email ?? "user@example.com",
                          style: TextStyle(
                            fontSize: Responsive.fontSize(3.5),
                            color: Colors.white.withOpacity(0.8),
                            fontFamily: 'Poppins',
                          ),
                        ),

                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: Responsive.height(2)),
              children: [
                _buildMenuItem(
                  icon: FontAwesomeIcons.house,
                  title: "Dashboard",
                  onTap: () {
                    Navigator.pop(context);
                  },
                  isDark: isDark,
                ),

                _buildMenuItem(
                  icon: FontAwesomeIcons.listCheck,
                  title: "All Tasks",
                  onTap: () {
                    Navigator.pop(context);
                  },
                  isDark: isDark,
                ),

                _buildMenuItem(
                  icon: FontAwesomeIcons.solidHeart,
                  title: "Favourite Tasks",
                  onTap: () {
                    Navigator.pop(context);
                  },
                  isDark: isDark,
                ),

                _buildMenuItem(
                  icon: FontAwesomeIcons.chartLine,
                  title: "Analytics",
                  onTap: () {
                    Navigator.pop(context);
                  },
                  isDark: isDark,
                ),

                _buildMenuItem(
                  icon: FontAwesomeIcons.userGroup,
                  title: "Team",
                  onTap: () {
                    Navigator.pop(context);
                  },
                  isDark: isDark,
                ),

                _buildMenuItem(
                  icon: FontAwesomeIcons.calendar,
                  title: "Calendar",
                  onTap: () {
                    Navigator.pop(context);
                  },
                  isDark: isDark,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.width(4),
                    vertical: Responsive.height(1),
                  ),
                  child: Divider(
                    color: isDark
                        ? Colors.white.withOpacity(0.1)
                        : Colors.grey.withOpacity(0.3),
                  ),
                ),

                _buildMenuItem(
                  icon: FontAwesomeIcons.gear,
                  title: "Settings",
                  onTap: () {
                    Navigator.pop(context);
                  },
                  isDark: isDark,
                ),

                _buildMenuItem(
                  icon: FontAwesomeIcons.circleQuestion,
                  title: "Help & Support",
                  onTap: () {
                    Navigator.pop(context);
                  },
                  isDark: isDark,
                ),

                _buildMenuItem(
                  icon: FontAwesomeIcons.rightFromBracket,
                  title: "Logout",
                  onTap: () {
                    Navigator.pop(context);
                    _showLogoutDialog(context, isDark);
                  },
                  isDark: isDark,
                  isLogout: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required bool isDark,
    bool isLogout = false,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Responsive.width(3),
        vertical: Responsive.height(0.5),
      ),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(Responsive.width(2.5)),
          decoration: BoxDecoration(
            color: isLogout
                ? Colors.red.withOpacity(0.1)
                : (isDark
                      ? Colors.white.withOpacity(0.1)
                      : AppColors.gradientStart.withOpacity(0.1)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: FaIcon(
            icon,
            color: isLogout
                ? Colors.red
                : (isDark ? Colors.white70 : AppColors.gradientStart),
            size: Responsive.fontSize(4.5),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: Responsive.fontSize(4.2),
            fontWeight: FontWeight.w600,
            color: isLogout
                ? Colors.red
                : (isDark ? Colors.white : Colors.black87),
            fontFamily: 'Poppins',
          ),
        ),
        trailing: FaIcon(
          FontAwesomeIcons.chevronRight,
          color: isDark ? Colors.white30 : Colors.grey[400],
          size: Responsive.fontSize(3.5),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        hoverColor: isDark
            ? Colors.white.withOpacity(0.05)
            : Colors.grey.withOpacity(0.05),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: isDark ? const Color(0xFF1A1A2E) : Colors.white,
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(Responsive.width(2)),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: FaIcon(
                FontAwesomeIcons.rightFromBracket,
                color: Colors.red,
                size: Responsive.fontSize(5),
              ),
            ),
            SizedBox(width: Responsive.width(3)),
            Text(
              'Logout',
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
        content: Text(
          'Are you sure you want to logout from your account?',
          style: TextStyle(
            fontFamily: "Poppins",
            color: isDark ? Colors.white70 : Colors.grey[600],
            height: 1.4,
            fontSize: Responsive.fontSize(3),
          ),
        ),
        actions: [
          TextButton(
            child: Text(
              'Cancel',
              style: TextStyle(
                fontFamily: "Poppins",
                color: isDark ? Colors.white70 : Colors.grey[600],
                fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: () => Navigator.of(dialogContext).pop(),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red.shade500, Colors.red.shade700],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Logout',
                style: TextStyle(
                  fontFamily: "Poppins",
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                authController.logout();
              },
            ),
          ),
        ],
      ),
    );
  }
}
