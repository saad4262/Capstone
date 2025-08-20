import 'dart:io';
import 'package:capstone/domain/viewmodels/darkmode_controller.dart';
import 'package:capstone/domain/viewmodels/eidtprofile_controller.dart';
import 'package:capstone/shared/constants/app_colors.dart';
import 'package:capstone/shared/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:image_picker/image_picker.dart';

class AvatarSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProfileController ctrl = Get.find();
    final ThemeController themeController = Get.find();

    return Obx(() {
      final isDark = themeController.isDarkMode.value;

      return GestureDetector(
        onTap: () async {
          final picked = await ImagePicker().pickImage(
            source: ImageSource.gallery,
            imageQuality: 80,
          );
          if (picked != null) ctrl.setAvatar(File(picked.path));
        },
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Obx(() {
              final avatar = ctrl.avatarFile.value;
              final user = ctrl.currentUser.value;
              return Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDark
                        ? Colors.grey[700]!
                        : Colors.white.withOpacity(0.3),
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: Responsive.width(16),
                  backgroundColor: Colors.white.withOpacity(0.2),
                  backgroundImage: avatar != null
                      ? FileImage(avatar)
                      : (user?.avatarUrl.isNotEmpty ?? false)
                      ? NetworkImage(user!.avatarUrl)
                      : null,
                  child: avatar == null && (user?.avatarUrl.isEmpty ?? true)
                      ? Icon(
                          Icons.person,
                          size: Responsive.width(16),
                          color: Colors.white.withOpacity(0.8),
                        )
                      : null,
                ),
              );
            }),
            Container(
              padding: EdgeInsets.all(Responsive.width(2)),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.edit,
                color: AppColors.gradientStart,
                size: Responsive.width(4),
              ),
            ),
          ],
        ),
      );
    });
  }
}
