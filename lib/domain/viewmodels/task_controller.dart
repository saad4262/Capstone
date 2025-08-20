import 'package:capstone/shared/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capstone/model/taskmodel/task_model.dart';
import 'package:capstone/data/repositories/task_repo.dart';

class TaskController extends GetxController {
  final TaskRepository _repository = TaskRepository();

  var category = 'Work'.obs;
  var status = 'pending'.obs;
  var startDate = DateTime.now().obs;
  var endDate = DateTime.now().add(Duration(days: 1)).obs;

  var tasks = <Task>[].obs;
  var isLoading = false.obs;
  var searchQuery = ''.obs;

  var isFormValid = false.obs;

  void validateForm(
    TextEditingController assignController,
    TextEditingController titleController,
    TextEditingController descriptionController,
  ) {
    isFormValid.value =
        assignController.text.trim().isNotEmpty &&
        titleController.text.trim().isNotEmpty &&
        descriptionController.text.trim().isNotEmpty;
  }

  void setCategory(String val) => category.value = val;
  void setStatus(String val) => status.value = val;

  void setStartDate(DateTime? val) {
    if (val != null) startDate.value = val;
  }

  void setEndDate(DateTime? val) {
    if (val != null) endDate.value = val;
  }

  void loadTasks(String userId) {
    isLoading.value = true;
    _repository.getTasksStream(userId).listen((event) {
      event.sort((a, b) => a.position.compareTo(b.position));

      tasks.value = event;
      isLoading.value = false;
    });
  }

  List<Task> get filteredTasks {
    if (searchQuery.value.isEmpty) return tasks;
    return tasks
        .where(
          (t) =>
              t.title.toLowerCase().contains(searchQuery.value.toLowerCase()),
        )
        .toList();
  }

  Future<void> addTask(Task task) async {
    try {
      isLoading.value = true;

      await _repository.addTask(task);

      await Future.delayed(const Duration(seconds: 2));

      isLoading.value = false;

      Get.snackbar(
        "Success",
        "Task added successfully",
        backgroundColor: AppColors.successColor,
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "Error",
        "Failed to add task",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.errorColor,
      );
    }
  }

  // Add this function in TaskController
  Future<void> updateTaskPositions(List<Task> updatedTasks) async {
    try {
      // isLoading.value = true;

      // Agar aapke TaskRepository me batch update method hai
      await _repository.updateTasksPositions(updatedTasks);

      // Update local observable list
      tasks.value = updatedTasks;

      // isLoading.value = false;
      // Get.snackbar(
      //   "Success",
      //   "Task order updated",
      //   backgroundColor: AppColors.successColor,
      // );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "Error",
        "Failed to update task order",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.errorColor,
      );
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      isLoading.value = true;

      await _repository.updateTask(task);

      await Future.delayed(const Duration(seconds: 2));

      isLoading.value = false;

      Get.snackbar(
        "Success",
        "Task Updated successfully",
        backgroundColor: AppColors.successColor,
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "Error",
        "Failed to Update task",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.errorColor,
      );
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      isLoading.value = true;

      await _repository.deleteTask(id);

      await Future.delayed(const Duration(seconds: 2));

      isLoading.value = false;

      Get.snackbar(
        "Success",
        "Task deleted successfully",
        backgroundColor: AppColors.successColor,
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "Error",
        "Failed to add task",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.errorColor,
      );
    }
  }
}
