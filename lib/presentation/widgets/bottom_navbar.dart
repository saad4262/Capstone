import 'package:capstone/domain/viewmodels/bottomnav_controller.dart';
import 'package:capstone/domain/viewmodels/user_controller.dart';
import 'package:capstone/shared/constants/app_colors.dart';
import 'package:capstone/shared/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CustomBottomNav extends StatelessWidget {
  final BottomNavController controller = Get.put(BottomNavController());
  final userController = Get.find<UserController>();

  final Function(int) onTabSelected;

  CustomBottomNav({super.key, required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 4,
        height: Responsive.height(7.5),
        child: SizedBox(
          height: Responsive.height(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(FontAwesomeIcons.house, 0),
              _buildNavItem(FontAwesomeIcons.listUl, 1),
              SizedBox(width: Responsive.width(5)),
              _buildNavItem(FontAwesomeIcons.solidHeart, 3),
              _buildNavItem(FontAwesomeIcons.solidUser, 4),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildNavItem(IconData icon, int index) {
    if (index == 4) {
      return Obx(
        () => InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            controller.changeIndex(index);
            onTabSelected(index);
          },
          child: CircleAvatar(
            radius: Responsive.fontSize(6),
            backgroundImage: userController.photoUrl.value.isNotEmpty
                ? NetworkImage(userController.photoUrl.value)
                : const AssetImage('assets/images/default_avatar.png')
                      as ImageProvider,
          ),
        ),
      );
    }

    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        controller.changeIndex(index);
        onTabSelected(index);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          controller.currentIndex.value == index
              ? ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      colors: [AppColors.gradientStart, AppColors.gradientEnd],

                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds);
                  },
                  child: FaIcon(
                    icon,
                    size: Responsive.fontSize(6),
                    color: Colors.white,
                  ),
                )
              : FaIcon(icon, size: Responsive.fontSize(6), color: Colors.grey),
        ],
      ),
    );
  }
}
