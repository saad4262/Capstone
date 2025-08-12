import 'package:get/get.dart';
import 'package:capstone/model/taskmodel/task_model.dart';
import 'package:capstone/data/repositories/task_repo.dart';

class TaskController extends GetxController {
  final TaskRepository _repository = TaskRepository();

  var tasks = <Task>[].obs;
  var isLoading = false.obs;

  void loadTasks(String userId) {
    isLoading.value = true;
    _repository.getTasksStream(userId).listen((event) {
      tasks.value = event;
      isLoading.value = false;
    });
  }

  Future<void> addTask(Task task) async {
    await _repository.addTask(task);
  }

  Future<void> updateTask(Task task) async {
    await _repository.updateTask(task);
  }

  Future<void> deleteTask(String id) async {
    await _repository.deleteTask(id);
  }

  
}
