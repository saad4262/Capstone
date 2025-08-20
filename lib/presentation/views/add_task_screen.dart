import 'package:capstone/data/repositories/notification_repo.dart';
import 'package:capstone/domain/viewmodels/favourite_controller.dart';
import 'package:capstone/domain/viewmodels/task_controller.dart';
import 'package:capstone/domain/viewmodels/darkmode_controller.dart';
import 'package:capstone/model/taskmodel/task_model.dart';
import 'package:capstone/shared/constants/app_colors.dart';
import 'package:capstone/shared/utils/responsive_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class TaskFormPage extends StatefulWidget {
  final Task? task;

  const TaskFormPage({Key? key, this.task}) : super(key: key);

  @override
  _TaskFormPageState createState() => _TaskFormPageState();
}

class _TaskFormPageState extends State<TaskFormPage> {
  late TextEditingController titleController;
  late TextEditingController assignController;
  late TextEditingController descriptionController;

  final TaskController taskController = Get.put(TaskController());
  final FavouriteTaskController controller = Get.put(FavouriteTaskController());
  final ThemeController themeController = Get.find();
  String get userId => FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.task?.title ?? '');
    assignController = TextEditingController(
      text: widget.task?.assignedToUserEmail ?? '',
    );
    descriptionController = TextEditingController(
      text: widget.task?.description ?? '',
    );

    taskController.validateForm(
      assignController,
      titleController,
      descriptionController,
    );

    if (widget.task != null) {
      taskController.setCategory(widget.task!.category);
      taskController.setStatus(widget.task!.status);
      taskController.setStartDate(widget.task!.startDate);
      taskController.setEndDate(widget.task!.endDate);
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    assignController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = themeController.isDarkMode.value;

      return Scaffold(
        backgroundColor: isDark
            ? const Color(0xFF0F0F0F)
            : const Color(0xFFF8F9FA),
        body: Stack(
          children: [
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      AppColors.gradientStart.withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.all(Responsive.padding(5)),
                child: Column(
                  children: [
                    SizedBox(height: Responsive.height(2)),

                    _buildHeader(isDark),

                    SizedBox(height: Responsive.height(3)),

                    _buildFormContainer(isDark),

                    SizedBox(height: Responsive.height(3)),

                    _buildActionButtons(isDark),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildHeader(bool isDark) {
    return Container(
      padding: EdgeInsets.all(Responsive.padding(6)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [
                  const Color(0xFF6366F1),
                  const Color(0xFF8B5CF6),
                  // const Color(0xFFEC4899),
                ]
              : [
                  AppColors.gradientStart,
                  AppColors.gradientEnd,
                  // const Color(0xFFFF6B9D),
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: AppColors.gradientStart.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(Responsive.width(4)),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: FaIcon(
              widget.task == null
                  ? FontAwesomeIcons.plus
                  : FontAwesomeIcons.edit,
              color: Colors.white,
              size: Responsive.fontSize(6),
            ),
          ),
          SizedBox(width: Responsive.width(13)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.task == null ? "Add Task" : "Edit Task",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w800,
                    fontSize: Responsive.fontSize(6.5),
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(height: Responsive.height(0.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormContainer(bool isDark) {
    return Container(
      padding: EdgeInsets.all(Responsive.padding(6)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFF1E1E28), const Color(0xFF2A2A3C)]
              : [Colors.white, Colors.grey.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.4)
                : Colors.grey.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
            spreadRadius: 2,
          ),
        ],
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.1)
              : Colors.grey.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          addTaskTextfield(
            "Assign User",
            assignController,
            FontAwesomeIcons.userPlus,
            isDark,
            onChanged: (_) => taskController.validateForm(
              assignController,
              titleController,
              descriptionController,
            ),
          ),
          SizedBox(height: Responsive.height(3)),

          addTaskTextfield(
            "Task Title",
            titleController,
            FontAwesomeIcons.heading,
            isDark,
            onChanged: (_) => taskController.validateForm(
              assignController,
              titleController,
              descriptionController,
            ),
          ),
          SizedBox(height: Responsive.height(3)),

          addTaskTextfield(
            "Description",
            descriptionController,
            FontAwesomeIcons.alignLeft,
            isDark,
            onChanged: (_) => taskController.validateForm(
              assignController,
              titleController,
              descriptionController,
            ),
          ),
          SizedBox(height: Responsive.height(3)),

          Obx(
            () => dropdown(
              'Category',
              taskController.category.value,
              ['Work', 'Personal', 'Other'],
              FontAwesomeIcons.layerGroup,
              isDark,
              (val) => taskController.setCategory(val ?? 'Work'),
            ),
          ),
          SizedBox(height: Responsive.height(3)),

          Obx(
            () => dropdown(
              'Status',
              taskController.status.value,
              ['pending', 'open', 'complete', 'review', 'blocked'],
              FontAwesomeIcons.tasks,
              isDark,
              (val) => taskController.setStatus(val ?? 'pending'),
              capitalizeItems: true,
            ),
          ),
          SizedBox(height: Responsive.height(3)),

          Obx(
            () => datePick(
              context,
              'Start Date',
              taskController.startDate.value,
              FontAwesomeIcons.calendarPlus,
              isDark,
              (picked) => taskController.setStartDate(picked),
              firstDate: DateTime.now(),
            ),
          ),
          SizedBox(height: Responsive.height(3)),

          Obx(
            () => datePick(
              context,
              'End Date',
              taskController.endDate.value,
              FontAwesomeIcons.calendarCheck,
              isDark,
              (picked) => taskController.setEndDate(picked),
            ),
          ),
        ],
      ),
    );
  }

  Widget addTaskTextfield(
    String label,
    TextEditingController controller,
    IconData icon,
    bool isDark, {
    int maxLines = 1,
    Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: Responsive.fontSize(4.2),
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black87,
            fontFamily: 'Poppins',
          ),
        ),
        SizedBox(height: Responsive.height(1)),
        Container(
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withOpacity(0.05)
                : Colors.grey.withOpacity(0.05),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.1)
                  : Colors.grey.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            onChanged: onChanged,
            style: TextStyle(
              fontSize: Responsive.fontSize(4),
              color: isDark ? Colors.white : Colors.black87,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              prefixIcon: Container(
                margin: EdgeInsets.all(Responsive.width(3)),
                padding: EdgeInsets.all(Responsive.width(2.5)),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.gradientStart.withOpacity(0.8),
                      AppColors.gradientEnd.withOpacity(0.8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: FaIcon(
                  icon,
                  color: Colors.white,
                  size: Responsive.fontSize(4),
                ),
              ),
              hintText: 'Enter $label',
              hintStyle: TextStyle(
                color: isDark ? Colors.white54 : Colors.grey[500],
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: Responsive.width(4),
                vertical: Responsive.height(2),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget dropdown(
    String label,
    String value,
    List<String> items,
    IconData icon,
    bool isDark,
    Function(String?) onChanged, {
    bool capitalizeItems = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: Responsive.fontSize(4.2),
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black87,
            fontFamily: 'Poppins',
          ),
        ),
        SizedBox(height: Responsive.height(1)),
        Container(
          padding: EdgeInsets.symmetric(horizontal: Responsive.width(4)),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withOpacity(0.05)
                : Colors.grey.withOpacity(0.05),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.1)
                  : Colors.grey.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: Responsive.width(3)),
                padding: EdgeInsets.all(Responsive.width(2.5)),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.gradientStart.withOpacity(0.8),
                      AppColors.gradientEnd.withOpacity(0.8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: FaIcon(
                  icon,
                  color: Colors.white,
                  size: Responsive.fontSize(3.5),
                ),
              ),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: value,
                    isExpanded: true,
                    dropdownColor: isDark
                        ? const Color(0xFF2A2A3C)
                        : Colors.white,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(4),
                      color: isDark ? Colors.white : Colors.black87,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                    items: items.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          capitalizeItems
                              ? item[0].toUpperCase() + item.substring(1)
                              : item,
                        ),
                      );
                    }).toList(),
                    onChanged: onChanged,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget datePick(
    BuildContext context,
    String label,
    DateTime? date,
    IconData icon,
    bool isDark,
    Function(DateTime) onDateSelected, {
    DateTime? firstDate,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: Responsive.fontSize(4.2),
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black87,
            fontFamily: 'Poppins',
          ),
        ),
        SizedBox(height: Responsive.height(1)),
        GestureDetector(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate:
                  (date != null && date.isAfter(firstDate ?? DateTime(2020)))
                  ? date
                  : (firstDate ?? DateTime.now()),

              firstDate: firstDate ?? DateTime(2020),
              lastDate: DateTime(2030),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(
                      primary: AppColors.gradientStart,
                      onPrimary: Colors.white,
                      surface: Colors.white,
                      onSurface: Colors.black,
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (picked != null) {
              onDateSelected(picked);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.width(4),
              vertical: Responsive.height(2),
            ),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withOpacity(0.05)
                  : Colors.grey.withOpacity(0.05),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: isDark
                    ? Colors.white.withOpacity(0.1)
                    : Colors.grey.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(Responsive.width(2.5)),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.gradientStart.withOpacity(0.8),
                        AppColors.gradientEnd.withOpacity(0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FaIcon(
                    icon,
                    color: Colors.white,
                    size: Responsive.fontSize(3.5),
                  ),
                ),
                SizedBox(width: Responsive.width(3)),
                Expanded(
                  child: Text(
                    date != null
                        ? "${date.day}/${date.month}/${date.year}"
                        : "Select Date",
                    style: TextStyle(
                      fontSize: Responsive.fontSize(4),
                      color: date != null
                          ? (isDark ? Colors.white : Colors.black87)
                          : (isDark ? Colors.white54 : Colors.grey[500]),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(bool isDark) {
    return Row(
      children: [
        // Cancel Button
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                width: 1,
              ),
            ),
            child: TextButton.icon(
              onPressed: () => Navigator.pop(context),

              label: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: Responsive.fontSize(4),
                  fontWeight: FontWeight.w600,
                  fontFamily: "Poppins",
                  color: isDark ? Colors.white70 : Colors.grey[700],
                ),
              ),
            ),
          ),
        ),

        SizedBox(width: Responsive.width(4)),

        // Submit Button
        Expanded(
          flex: 1,
          child: Obx(() {
            final isDisabled =
                controller.isLoading.value || !taskController.isFormValid.value;

            return Container(
              decoration: BoxDecoration(
                gradient: isDisabled
                    ? LinearGradient(
                        colors: [Colors.grey.shade400, Colors.grey.shade500],
                      )
                    : LinearGradient(
                        colors: [
                          AppColors.gradientStart,
                          AppColors.gradientEnd,
                          const Color(0xFFFF6B9D),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                borderRadius: BorderRadius.circular(18),
                boxShadow: isDisabled
                    ? []
                    : [
                        BoxShadow(
                          color: AppColors.gradientStart.withOpacity(0.4),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
              ),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(vertical: Responsive.height(2)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                onPressed: isDisabled
                    ? () => Get.snackbar(
                        "Form Incomplete",
                        "Please fill all required fields",
                        backgroundColor: AppColors.errorColor,
                
                      )
                    : () async {
                        controller.isLoading.value = true;

                        final newTask = Task(
                          id:
                              widget.task?.id ??
                              FirebaseFirestore.instance
                                  .collection('tasks')
                                  .doc()
                                  .id,
                          userId: userId,
                          assignedToUserEmail: assignController.text.trim(),
                          title: titleController.text.trim(),
                          description: descriptionController.text.trim(),
                          category: taskController.category.value,
                          status: taskController.status.value,
                          startDate: taskController.startDate.value,
                          endDate: taskController.endDate.value,
                          createdAt: widget.task?.createdAt ?? Timestamp.now(),
                          updatedAt: Timestamp.now(),
                        );

                        if (widget.task == null) {
                          await taskController.addTask(newTask);
                        } else {
                          await taskController.updateTask(newTask);
                        }

                        if (newTask.assignedUserTokens.isNotEmpty) {
                          for (String token in newTask.assignedUserTokens) {
                            await sendTaskNotification(
                              token,
                              widget.task == null
                                  ? "Hey! You have a new task assigned."
                                  : "Your task has been updated.",
                            );
                          }
                        }

                        controller.isLoading.value = false;
                        Navigator.pop(context);
                      },
                icon: controller.isLoading.value
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : FaIcon(
                        widget.task == null
                            ? FontAwesomeIcons.plus
                            : FontAwesomeIcons.floppyDisk,
                        color: Colors.white,
                        size: Responsive.fontSize(4),
                      ),
                label: Text(
                  controller.isLoading.value
                      ? 'Processing...'
                      : (widget.task == null ? 'Add' : 'Update'),
                  style: TextStyle(
                    fontSize: Responsive.fontSize(4.5),
                    fontWeight: FontWeight.w700,
                    fontFamily: "Poppins",
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
