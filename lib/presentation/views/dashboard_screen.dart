import 'package:capstone/domain/viewmodels/dashboard_controller.dart';
import 'package:capstone/domain/viewmodels/darkmode_controller.dart';
import 'package:capstone/presentation/views/tastStats_screen.dart';
import 'package:capstone/presentation/widgets/appbar.dart';
import 'package:capstone/presentation/widgets/custom_drawer.dart';
import 'package:capstone/presentation/widgets/dashboard_header.dart';
import 'package:capstone/presentation/widgets/statics_header.dart';
import 'package:capstone/presentation/widgets/task_data.dart';
import 'package:capstone/shared/constants/app_colors.dart';
import 'package:capstone/shared/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  final DashboardController controller = Get.put(DashboardController());
  final ThemeController themeController = Get.find();

  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = themeController.isDarkMode.value;

      return Scaffold(
        drawer: CustomDrawer(),
        resizeToAvoidBottomInset: false,
        extendBody: true,

        backgroundColor: isDark ? AppColors.black : Colors.grey[50],
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Responsive.height(2)),

              CustomAppBar(title: "Task Overview"),

              SizedBox(height: Responsive.height(2)),

              dashboardHeader(isDark),

              taskData(isDark),

              SizedBox(height: Responsive.height(3)),

              staticsHeader(isDark),

              SizedBox(height: Responsive.height(2)),

              Container(
                margin: EdgeInsets.symmetric(horizontal: Responsive.width(4)),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[800] : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: isDark
                          ? Colors.black.withOpacity(0.3)
                          : Colors.grey.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: TaskStatsScreen(),
              ),

              SizedBox(height: Responsive.height(3)),
            ],
          ),
        ),
      );
    });
  }
}
