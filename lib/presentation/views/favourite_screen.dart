import 'package:capstone/domain/viewmodels/darkmode_controller.dart';
import 'package:capstone/domain/viewmodels/favourite_controller.dart';
import 'package:capstone/domain/viewmodels/task_controller.dart';
import 'package:capstone/presentation/widgets/appbar.dart';
import 'package:capstone/presentation/widgets/custom_drawer.dart';
import 'package:capstone/presentation/widgets/favour_card.dart';
import 'package:capstone/shared/constants/app_colors.dart';
import 'package:capstone/shared/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FavouriteScreen extends StatelessWidget {
  final String userId;
  FavouriteScreen({super.key, required this.userId});

  final FavouriteTaskController controller = Get.put(FavouriteTaskController());
  final ThemeController themeController = Get.find();
  final TaskController taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    controller.loadFavourites(userId);

    return Obx(() {
      final isDark = themeController.isDarkMode.value;

      return Scaffold(
        drawer: CustomDrawer(),

        backgroundColor: isDark
            ? const Color(0xFF0F0F0F)
            : const Color(0xFFF5F7FA),
        body: Column(
          children: [
            SizedBox(height: Responsive.height(2)),
            CustomAppBar(title: "Favourite"),

            Container(
              margin: EdgeInsets.all(Responsive.width(4)),
              padding: EdgeInsets.all(Responsive.width(5)),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [AppColors.gradientStart, AppColors.gradientEnd]
                      : [AppColors.gradientStart, AppColors.gradientEnd],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF667EEA).withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  SizedBox(width: Responsive.width(4)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "My Favourite Tasks",
                          style: TextStyle(
                            fontSize: Responsive.fontSize(5.5),
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(height: Responsive.height(0.5)),
                        Obx(
                          () => Text(
                            "${controller.favouriteTasks.length} tasks in your collection",
                            style: TextStyle(
                              fontSize: Responsive.fontSize(3.5),
                              color: Colors.white.withOpacity(0.8),
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(Responsive.width(2.5)),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Obx(
                      () => Text(
                        "${controller.favouriteTasks.length}",
                        style: TextStyle(
                          fontSize: Responsive.fontSize(5),
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Obx(() {
                if (controller.favouriteTasks.isEmpty) {
                  return emptyCard(isDark);
                }

                return ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.width(4),
                    vertical: Responsive.height(1),
                  ),
                  itemCount: controller.favouriteTasks.length,
                  itemBuilder: (context, index) {
                    final task = controller.favouriteTasks[index];
                    return favCard(task, isDark, context, index);
                  },
                );
              }),
            ),
          ],
        ),
      );
    });
  }

  Widget emptyCard(bool isDark) {
    return Center(
      child: Text(
        "No Favourite Tasks Yet!",
        style: TextStyle(
          fontSize: Responsive.fontSize(5.5),
          fontWeight: FontWeight.bold,
          color: isDark ? AppColors.white : AppColors.black,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }

  Widget favCard(dynamic task, bool isDark, BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: Responsive.height(2)),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A2E) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : Colors.grey.withOpacity(0.12),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.1)
              : Colors.grey.withOpacity(0.1),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          // Navigate to task detail
        },
        child: Padding(
          padding: EdgeInsets.all(Responsive.width(5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with title and heart
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.title ?? "Untitled Task",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: Responsive.fontSize(5),
                            fontWeight: FontWeight.w700,
                            color: isDark ? Colors.white : Colors.black87,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        if (task.description != null &&
                            task.description!.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(
                              top: Responsive.padding(0.5,),
                              right: Responsive.padding(0.2,)
                            ),
                            child: Text(
                              task.description!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: Responsive.fontSize(3.3),
                                color: isDark
                                    ? Colors.white70
                                    : Colors.grey[600],
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(Responsive.width(2.5)),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.red.shade400, Colors.pink.shade400],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        controller.toggleFavourite(task, userId);
                      },
                      child: FaIcon(
                        FontAwesomeIcons.solidHeart,
                        color: Colors.white,
                        size: Responsive.fontSize(4.5),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: Responsive.height(2.5)),

              Row(
                children: [
                  favourCard(
                    statusColor(task.status ?? "pending"),
                    capitalizeFirst(task.status ?? "pending"),
                    getStatusIcon(task.status ?? "pending"),
                    isDark,
                  ),
                  SizedBox(width: Responsive.width(2)),
                  favourCard(
                    Colors.blue.shade600,
                    task.endDate != null
                        ? DateFormat('MMM dd, yyyy').format(task.endDate)
                        : "No due date",
                    FontAwesomeIcons.calendar,
                    isDark,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  String capitalizeFirst(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  Color statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'review':
        return Colors.purple;
      case 'completed':
        return Colors.green;
      case 'open':
        return Colors.indigo;
      case 'blocked':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return FontAwesomeIcons.clock;
      case 'review':
        return FontAwesomeIcons.magnifyingGlass;
      case 'completed':
        return FontAwesomeIcons.circleCheck;
      case 'open':
        return FontAwesomeIcons.folderOpen;
      case 'blocked':
        return FontAwesomeIcons.ban;
      default:
        return FontAwesomeIcons.circle;
    }
  }
}
