import 'package:capstone/domain/viewmodels/darkmode_controller.dart';
import 'package:capstone/domain/viewmodels/favourite_controller.dart';
import 'package:capstone/domain/viewmodels/task_controller.dart';
import 'package:capstone/model/taskmodel/task_model.dart';
import 'package:capstone/presentation/views/add_task_screen.dart';
import 'package:capstone/shared/constants/app_colors.dart';
import 'package:capstone/shared/utils/responsive_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TaskDetailPage extends StatelessWidget {
  final Task task;
  TaskDetailPage({required this.task, Key? key}) : super(key: key);

  final TaskController taskController = Get.put(TaskController());
  final FavouriteTaskController favController = Get.put(
    FavouriteTaskController(),
  );

  final userId = FirebaseAuth.instance.currentUser!.uid;

  Color categoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'work':
        return Colors.blue.shade600;
      case 'personal':
        return Colors.green.shade600;
      case 'other':
        return Colors.orange.shade600;
      default:
        return Colors.grey.shade600;
    }
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange.shade600;
      case 'review':
        return Colors.purple.shade600;
      case 'completed':
        return Colors.teal.shade600;
      case 'open':
        return Colors.indigo.shade600;
      case 'blocked':
        return Colors.red.shade600;
      default:
        return Colors.grey.shade600;
    }
  }

  void confirmDelete(BuildContext context, String taskId) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Delete Task',
          style: TextStyle(
            fontSize: Responsive.fontSize(5),
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'Are you sure you want to delete this task?',
          style: TextStyle(fontSize: Responsive.fontSize(4)),
        ),
        actions: [
          TextButton(
            child: Text(
              'Cancel',
              style: TextStyle(
                fontSize: Responsive.fontSize(4),
                color: Colors.grey,
              ),
            ),
            onPressed: () => Navigator.of(dialogContext).pop(),
          ),
          ElevatedButton(
            child: Text(
              'Delete',
              style: TextStyle(fontSize: Responsive.fontSize(4)),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              taskController.deleteTask(taskId);
              Navigator.of(dialogContext).pop();
            },
          ),
        ],
      ),
    );
  }

  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = themeController.isDarkMode.value;
    final duration = task.endDate.difference(DateTime.now());

    final days = duration.inDays;
    // final hours = duration.inHours % 24;
    // final minutes = duration.inMinutes % 60;
    // final seconds = duration.inSeconds % 60;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Responsive.padding(5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Responsive.height(4)),
            Row(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: CircleAvatar(
                      backgroundColor: isDark
                          ? Colors.grey[800]
                          : AppColors.lightgrey,
                      radius: Responsive.radius(7),
                      child: FaIcon(
                        FontAwesomeIcons.angleLeft,
                        color: isDark ? Colors.white : AppColors.grey,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: Responsive.width(14)),

                Center(
                  child: Text(
                    "Task Details",
                    style: TextStyle(
                      fontSize: Responsive.fontSize(6),
                      fontFamily: "poppins",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Responsive.height(2)),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: Responsive.height(0)),
              child: Container(
                width: Responsive.width(90),
                height: Responsive.height(15),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  color: isDark
                      ? Colors.grey[800]
                      : Color.fromARGB(
                          248,
                          241,
                          239,
                          239,
                        ), 
                  child: Padding(
                    padding: EdgeInsets.all(Responsive.padding(3)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            task.title,
                            style: TextStyle(
                              fontSize: Responsive.fontSize(6),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        SizedBox(width: Responsive.width(4)),

                        CircularPercentIndicator(
                          radius: Responsive.radius(7),
                          lineWidth: 6,
                          percent: getTimeProgress(task),
                          center: Text(
                            "${(getTimeProgress(task) * 100).toStringAsFixed(0)}%",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          progressColor: AppColors.gradientStart,
                          backgroundColor: Colors.grey.shade300,
                          circularStrokeCap: CircularStrokeCap.round,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: Responsive.height(2)),

            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.width(3),
                    vertical: Responsive.height(0.8),
                  ),
                  decoration: BoxDecoration(
                    color: categoryColor(task.category),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    task.category,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Responsive.fontSize(3.5),
                    ),
                  ),
                ),
                SizedBox(width: Responsive.width(2)),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.width(3),
                    vertical: Responsive.height(0.8),
                  ),
                  decoration: BoxDecoration(
                    color: _statusColor(task.status),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    task.status.capitalizeFirst ?? task.status,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Responsive.fontSize(3.5),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Responsive.height(2)),
            Text(
              "Description",
              style: TextStyle(
                fontSize: Responsive.fontSize(5),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Responsive.height(1)),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: Responsive.padding(1)),
              child: Text(
                task.description ?? "-",
                style: TextStyle(
                  fontSize: Responsive.fontSize(4),
                  fontFamily: 'Poppins',
                ),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: Responsive.height(3)),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Start Date",
                      style: TextStyle(
                        fontSize: Responsive.fontSize(3.5),
                        fontWeight: FontWeight.bold,
                        fontFamily: "poppins",
                      ),
                    ),
                    Text(
                      DateFormat('EEE, dd MMM yyyy').format(task.startDate),
                      style: TextStyle(
                        fontSize: Responsive.fontSize(3),
                        color: theme.textTheme.bodyMedium?.color,
                        fontFamily: "poppins",
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "End Date",
                      style: TextStyle(
                        fontSize: Responsive.fontSize(3.5),
                        fontWeight: FontWeight.bold,
                        fontFamily: "poppins",
                      ),
                    ),
                    Text(
                      DateFormat('EEE, dd MMM yyyy').format(task.endDate),
                      style: TextStyle(
                        fontSize: Responsive.fontSize(3),
                        color: theme.textTheme.bodyMedium?.color,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: Responsive.height(3)),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(Responsive.width(5)),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[800] : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: isDark
                        ? Colors.black.withOpacity(0.3)
                        : Colors.grey.withOpacity(0.1),
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ],
                border: Border.all(
                  color: isDark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.grey.withOpacity(0.2),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(Responsive.width(4)),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.gradientStart,
                          AppColors.gradientEnd,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.user,
                      color: Colors.white,
                      size: Responsive.fontSize(5),
                    ),
                  ),
                  SizedBox(width: Responsive.width(4)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Assigned To",
                          style: TextStyle(
                            fontSize: Responsive.fontSize(3),
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: Responsive.height(0.5)),
                        Text(
                          task.assignedToUserEmail,
                          style: TextStyle(
                            fontSize: Responsive.fontSize(3.5),
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: Responsive.height(3)),

            Padding(
              padding: EdgeInsets.only(right: Responsive.padding(5)),
              child: Align(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,

                  children: [
                    FaIcon(FontAwesomeIcons.clock),
                    SizedBox(width: Responsive.width(3)),

                    Text(
                      "$days days left",
                      style: TextStyle(fontSize: 12, fontFamily: "poppins"),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: Responsive.height(3)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: [
                // Edit Button
                InkWell(
                  onTap: () => Get.to(() => TaskFormPage(task: task)),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: Responsive.width(35), 
                    height: Responsive.height(7), 
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.gradientStart,
                          AppColors.gradientEnd,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.gradientStart.withOpacity(0.3),
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: Responsive.fontSize(4.5),
                        ),
                        SizedBox(width: Responsive.width(2)),
                        Text(
                          "Edit",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Responsive.fontSize(4),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: Responsive.width(3)),

                InkWell(
                  onTap: () => confirmDelete(context, task.id),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: Responsive.width(35), 
                    height: Responsive.height(7), 
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.red.shade400, Colors.red.shade700],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.3),
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: Responsive.fontSize(4.5),
                        ),
                        SizedBox(width: Responsive.width(2)),
                        Text(
                          "Delete",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Responsive.fontSize(4),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  double getTimeProgress(Task task) {
    final now = DateTime.now();
    final totalDuration = task.endDate.difference(task.startDate).inSeconds;
    final elapsed = now.difference(task.startDate).inSeconds;

    return (elapsed / totalDuration).clamp(0.0, 1.0);
  }
}
