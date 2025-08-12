import 'package:capstone/domain/viewmodels/darkmode_controller.dart';
import 'package:capstone/shared/utils/responsive_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:capstone/model/taskmodel/task_model.dart';
import 'package:capstone/domain/viewmodels/task_controller.dart';

class TaskScreen extends StatelessWidget {
  final TaskController taskController = Get.find<TaskController>();
  final ThemeController themeController = Get.find();

  TaskScreen({super.key});

  String get userId => FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    taskController.loadTasks(userId);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Your Tasks",
          style: TextStyle(
            color: Colors.black87,
            fontSize: Responsive.fontSize(5),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Obx(() {
            return IconButton(
              icon: Icon(
                themeController.isDarkMode.value
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),
              onPressed: () {
                themeController.toggleTheme();
              },
            );
          }),
        ],
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Obx(() {
        if (taskController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (taskController.tasks.isEmpty) {
          return Center(
            child: Text(
              'No tasks assigned',
              style: TextStyle(
                fontSize: Responsive.fontSize(4),
                color: Colors.grey[600],
              ),
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: Responsive.height(2)),
          itemCount: taskController.tasks.length,
          itemBuilder: (context, index) {
            final task = taskController.tasks[index];

            return Container(
              margin: EdgeInsets.symmetric(
                horizontal: Responsive.width(4),
                vertical: Responsive.height(1),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: Responsive.width(5),
                  vertical: Responsive.height(2),
                ),
                title: Text(
                  task.title,
                  style: TextStyle(
                    fontSize: Responsive.fontSize(5),
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(top: Responsive.height(0.8)),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Responsive.width(3),
                          vertical: Responsive.height(0.5),
                        ),
                        decoration: BoxDecoration(
                          color: _categoryColor(task.category),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          task.category,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Responsive.fontSize(3.5),
                          ),
                        ),
                      ),
                      SizedBox(width: Responsive.width(3)),
                      Text(
                        'Status: ${task.status.capitalizeFirst ?? task.status}',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(4),
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete_outline, color: Colors.red[400]),
                  iconSize: Responsive.fontSize(6),
                  onPressed: () => _confirmDelete(context, task.id),
                ),
                onTap: () => _showTaskDialog(context, task: task),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () => _showTaskDialog(context),
        child: Icon(Icons.add, size: Responsive.fontSize(7)),
      ),
    );
  }

  Color _categoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'work':
        return Colors.blueAccent;
      case 'personal':
        return Colors.green;
      case 'other':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  void _confirmDelete(BuildContext context, String taskId) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Delete Task',
          style: TextStyle(fontSize: Responsive.fontSize(5)),
        ),
        content: Text(
          'Are you sure you want to delete this task?',
          style: TextStyle(fontSize: Responsive.fontSize(4)),
        ),
        actions: [
          TextButton(
            child: Text(
              'Cancel',
              style: TextStyle(fontSize: Responsive.fontSize(4)),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: Text(
              'Delete',
              style: TextStyle(fontSize: Responsive.fontSize(4)),
            ),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () {
              taskController.deleteTask(taskId);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _showTaskDialog(BuildContext context, {Task? task}) {
    final titleController = TextEditingController(text: task?.title ?? '');
    final assignController = TextEditingController(
      text: task?.assignedToUserEmail ?? '',
    );
    final descriptionController = TextEditingController(
      text: task?.description ?? '',
    );
    String category = task?.category ?? 'Work';
    String status = task?.status ?? 'pending';
    DateTime startDate = task?.startDate ?? DateTime.now();
    DateTime endDate =
        task?.endDate ?? DateTime.now().add(const Duration(days: 1));

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(Responsive.width(5)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            task == null ? 'Add Task' : 'Edit Task',
            style: TextStyle(
              fontSize: Responsive.fontSize(6),
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField('Title', assignController),
                SizedBox(height: Responsive.height(2)),

                _buildTextField('Title', titleController),
                SizedBox(height: Responsive.height(2)),
                _buildTextField(
                  'Description',
                  descriptionController,
                  maxLines: 3,
                ),
                SizedBox(height: Responsive.height(2)),
                _buildDropdown('Category', category, [
                  'Work',
                  'Personal',
                  'Other',
                ], (val) => category = val ?? 'Work'),
                SizedBox(height: Responsive.height(2)),
                _buildDropdown(
                  'Status',
                  status,
                  ['pending', 'open', 'complete', 'review', 'blocked'],
                  (val) => status = val ?? 'pending',
                  capitalizeItems: true,
                ),
                SizedBox(height: Responsive.height(2)),
                _buildDatePicker(context, 'Start Date', startDate, (picked) {
                  if (picked != null) startDate = picked;
                }),
                SizedBox(height: Responsive.height(1)),
                _buildDatePicker(context, 'End Date', endDate, (picked) {
                  if (picked != null) endDate = picked;
                }),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(fontSize: Responsive.fontSize(4)),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.width(8),
                  vertical: Responsive.height(1.5),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                final newTask = Task(
                  id:
                      task?.id ??
                      FirebaseFirestore.instance.collection('tasks').doc().id,
                  userId: userId,
                  assignedToUserEmail: assignController.text.trim(),
                  title: titleController.text.trim(),
                  description: descriptionController.text.trim(),
                  category: category,
                  status: status,
                  startDate: startDate,
                  endDate: endDate,
                  createdAt: task?.createdAt ?? Timestamp.now(),
                  updatedAt: Timestamp.now(),
                );

                if (task == null) {
                  await taskController.addTask(newTask);
                } else {
                  await taskController.updateTask(newTask);
                }

                Navigator.pop(context);
              },
              child: Text(
                task == null ? 'Add' : 'Update',
                style: TextStyle(
                  fontSize: Responsive.fontSize(5),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: TextStyle(fontSize: Responsive.fontSize(4)),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: Responsive.fontSize(4)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: EdgeInsets.symmetric(
          horizontal: Responsive.width(4),
          vertical: Responsive.height(1.5),
        ),
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    String currentValue,
    List<String> options,
    void Function(String?) onChanged, {
    bool capitalizeItems = false,
  }) {
    return DropdownButtonFormField<String>(
      value: currentValue,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: Responsive.fontSize(4)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: EdgeInsets.symmetric(
          horizontal: Responsive.width(4),
          vertical: Responsive.height(1.5),
        ),
      ),
      items: options
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(
                capitalizeItems ? (e.capitalizeFirst ?? e) : e,
                style: TextStyle(fontSize: Responsive.fontSize(4)),
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildDatePicker(
    BuildContext context,
    String label,
    DateTime date,
    void Function(DateTime?) onDatePicked,
  ) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '$label: ${date.toLocal().toString().split(' ')[0]}',
            style: TextStyle(fontSize: Responsive.fontSize(4)),
          ),
        ),
        TextButton(
          onPressed: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime.now().subtract(const Duration(days: 365)),
              lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
            );
            onDatePicked(picked);
          },
          child: Text(
            'Pick',
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: Responsive.fontSize(4),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
