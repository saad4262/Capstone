import 'package:capstone/data/services/task_service.dart';
import 'package:capstone/model/taskmodel/task_model.dart';

class TaskRepository {
  final TaskService _taskService = TaskService();

  Stream<List<Task>> getTasksStream(String userId) {
    return _taskService.getTasksByUser(userId);
  }

  Future<void> addTask(Task task) => _taskService.addTask(task);

  Future<void> updateTask(Task task) => _taskService.updateTask(task);

  Future<void> deleteTask(String taskId) => _taskService.deleteTask(taskId);
  
  Stream<List<Task>> getTasksStreams() {
    return _taskService.getTasksStream();
  }

  Future<void> updateTasksPositions(List<Task> tasks) {
    return _taskService.updateTaskPositions(tasks);
  }
}
