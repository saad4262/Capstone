import 'package:capstone/domain/viewmodels/darkmode_controller.dart';
import 'package:capstone/domain/viewmodels/favourite_controller.dart';
import 'package:capstone/domain/viewmodels/user_controller.dart';
import 'package:capstone/model/taskmodel/task_model.dart';
import 'package:capstone/presentation/views/add_task_screen.dart';
import 'package:capstone/presentation/views/task_detail_screen.dart';
import 'package:capstone/presentation/widgets/appbar.dart';
import 'package:capstone/presentation/widgets/custom_drawer.dart';
import 'package:capstone/shared/constants/app_colors.dart';
import 'package:capstone/shared/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:capstone/domain/viewmodels/task_controller.dart';

class TaskScreen extends StatelessWidget {
  final TaskController taskController = Get.find<TaskController>();
  final ThemeController themeController = Get.find();
  final FavouriteTaskController controller = Get.put(FavouriteTaskController());

  TaskScreen({super.key});

  String get userId => FirebaseAuth.instance.currentUser!.uid;

  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    taskController.loadTasks(userId);

    return Obx(() {
      final isDark = themeController.isDarkMode.value;
      final theme = Theme.of(context);

      return Scaffold(
        drawer: CustomDrawer(),

        backgroundColor: theme.scaffoldBackgroundColor,
        body: Column(
          children: [
            SizedBox(height: Responsive.height(2)),
            CustomAppBar(title: "Tasks"),
            SizedBox(height: Responsive.height(3)),

            Container(
              margin: EdgeInsets.symmetric(horizontal: Responsive.width(4)),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(Responsive.width(8)),
                boxShadow: [
                  BoxShadow(
                    color: isDark
                        ? Colors.black.withOpacity(0.3)
                        : Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
                border: Border.all(
                  color: isDark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.grey.withOpacity(0.2),
                ),
              ),
              child: TextField(
                onChanged: (value) => taskController.searchQuery.value = value,
                style: TextStyle(
                  fontSize: Responsive.fontSize(4),
                  fontFamily: 'Poppins',
                  color: theme.textTheme.bodyLarge?.color,
                ),
                decoration: InputDecoration(
                  prefixIcon: Container(
                    margin: EdgeInsets.all(Responsive.margin(3)),
                    padding: EdgeInsets.all(Responsive.padding(3)),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.gradientStart,
                          AppColors.gradientEnd,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: Responsive.fontSize(4.5),
                    ),
                  ),
                  hintText: "Search tasks...",
                  hintStyle: TextStyle(
                    fontFamily: 'Poppins',
                    color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
                    fontSize: Responsive.fontSize(4.5),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: Responsive.width(4),
                    vertical: Responsive.height(2),
                  ),
                ),
              ),
            ),

            SizedBox(height: Responsive.height(2)),

            Expanded(
              child: Obx(() {
                if (taskController.isLoading.value) {
                  return Center(
                    child: Container(
                      padding: EdgeInsets.all(Responsive.width(8)),
                      decoration: BoxDecoration(
                        color: theme.cardColor,
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
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.gradientStart,
                              ),
                              backgroundColor: isDark
                                  ? Colors.white.withOpacity(0.1)
                                  : Colors.grey.withOpacity(0.2),
                            ),
                          ),
                          SizedBox(height: Responsive.height(2)),
                          Text(
                            "Loading tasks...",
                            style: TextStyle(
                              fontSize: Responsive.fontSize(4),
                              fontFamily: 'Poppins',
                              color: theme.textTheme.bodyMedium?.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                if (taskController.tasks.isEmpty) {
                  return Center(
                    child: Container(
                      margin: EdgeInsets.all(Responsive.width(8)),
                      padding: EdgeInsets.all(Responsive.width(6)),
                      decoration: BoxDecoration(
                        color: theme.cardColor,
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
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
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
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(
                              Icons.task_outlined,
                              size: Responsive.fontSize(8),
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: Responsive.height(2)),
                          Text(
                            'No tasks assigned',
                            style: TextStyle(
                              fontSize: Responsive.fontSize(5),
                              color: theme.textTheme.headlineSmall?.color,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: Responsive.height(1)),
                          Text(
                            'Tasks will appear here when assigned',
                            style: TextStyle(
                              fontSize: Responsive.fontSize(3.5),
                              color: theme.textTheme.bodyMedium?.color
                                  ?.withOpacity(0.7),
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return ReorderableListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.width(4),
                    vertical: Responsive.height(1),
                  ),

                  itemCount: taskController.filteredTasks.length,
                  onReorder: (oldIndex, newIndex) {
                    if (newIndex > oldIndex) newIndex--;

                    final tasksList = List<Task>.from(
                      taskController.tasks,
                    ); 
                    final movedTask = tasksList.removeAt(oldIndex);
                    tasksList.insert(newIndex, movedTask);

                    for (int i = 0; i < tasksList.length; i++) {
                      tasksList[i] = tasksList[i].copyWith(position: i);
                    }

                    taskController.updateTaskPositions(tasksList);
                  },

                  itemBuilder: (context, index) {
                    final task = taskController.filteredTasks[index];
                    final isFav = task.favouriteByUsers.contains(userId);
                    return Slidable(
                      key: ValueKey(task.id),
                      endActionPane: ActionPane(
                        motion: const StretchMotion(),
                        extentRatio: 0.4,
                        children: [
                          SlidableAction(
                            onPressed: (context) =>
                                Get.to(() => TaskFormPage(task: task)),
                            backgroundColor: Colors.blue.shade600,
                            foregroundColor: Colors.white,
                            icon: Icons.edit,
                            label: 'Edit',
                            borderRadius: BorderRadius.circular(12),
                            spacing: 6,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                          ),

                          SlidableAction(
                            onPressed: (context) =>
                                _confirmDelete(context, task.id),
                            backgroundColor: Colors.red.shade600,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                            borderRadius: BorderRadius.circular(12),
                            spacing: 6,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                          ),
                        ],
                      ),

                      child: Container(
                        margin: EdgeInsets.only(bottom: Responsive.height(2)),
                        decoration: BoxDecoration(
                          color: theme.cardColor,
                          borderRadius: BorderRadius.circular(
                            Responsive.radius(4),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: isDark
                                  ? Colors.black.withOpacity(0.2)
                                  : Colors.grey.withOpacity(0.1),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(
                            Responsive.radius(4),
                          ),
                          onTap: () => Get.to(() => TaskDetailPage(task: task)),
                          child: Padding(
                            padding: EdgeInsets.all(Responsive.padding(3)),
                            child: Row(
                              children: [
                                Container(
                                  width: Responsive.width(9),
                                  height: Responsive.width(9),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: statusColor(task.status),
                                  ),
                                  child: Center(
                                    child: FaIcon(
                                      statusIcon(task.status),
                                      color: Colors.white,
                                      size: Responsive.fontSize(4.2),
                                    ),
                                  ),
                                ),
                                SizedBox(width: Responsive.width(4)),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        task.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: Responsive.fontSize(5),
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      SizedBox(height: Responsive.height(0.8)),
                                      Text(
                                        "${task.category} • ${task.status[0].toUpperCase()}${task.status.substring(1)}",
                                        style: TextStyle(
                                          fontSize: Responsive.fontSize(3.2),
                                          color: theme
                                              .textTheme
                                              .bodyMedium
                                              ?.color
                                              ?.withOpacity(0.7),
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: Responsive.width(2),
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      isFav
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isFav ? Colors.red : Colors.grey,
                                      size: Responsive.fontSize(7),
                                    ),
                                    onPressed: () => controller.toggleFavourite(
                                      task,
                                      userId,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      );
    });
  }

  Color statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'work':
        return Colors.blue.shade600;
      case 'person':
        return Colors.green.shade600;
      case 'pending':
        return Colors.orange.shade600;
      case 'review':
        return Colors.purple.shade600;
      case 'completed':
        return Colors.teal.shade600;
      case 'open':
        return Colors.indigo.shade600;
      case 'block':
        return Colors.red.shade600;
      default:
        return Colors.grey.shade600;
    }
  }

  static IconData statusIcon(String status) {
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

  void _confirmDelete(BuildContext context, String taskId) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Delete Task',
          style: TextStyle(
            fontSize: Responsive.fontSize(5),
            fontWeight: FontWeight.w600,
            fontFamily: "Poppins",
            color: Theme.of(context).textTheme.headlineSmall?.color,
          ),
        ),
        content: Text(
          'Are you sure you want to delete this task?',
          style: TextStyle(
            fontSize: Responsive.fontSize(4),
            fontFamily: "Poppins",
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
        actions: [
          TextButton(
            child: Text(
              'Cancel',
              style: TextStyle(
                fontSize: Responsive.fontSize(4),
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins",
                color: Colors.grey,
              ),
            ),
            onPressed: () => Navigator.of(dialogContext).pop(),
          ),
          ElevatedButton(
            child: Text(
              'Delete',
              style: TextStyle(
                fontSize: Responsive.fontSize(4),
                fontWeight: FontWeight.w600,
                fontFamily: "Poppins",
                color: Colors.white,
              ),
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
}
