import 'package:capstone/data/repositories/task_repo.dart';
import 'package:capstone/model/taskmodel/task_model.dart';
import 'package:get/get.dart';


class DashboardController extends GetxController {
  final TaskRepository _repository = TaskRepository();

  var tasks = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();
    _repository.getTasksStreams().listen((taskList) {
      tasks.value = taskList;
    });
  }

  int get pendingCount => tasks.where((t) => t.status == "pending").length;
  int get reviewCount => tasks.where((t) => t.status == "review").length;
  int get completedCount => tasks.where((t) => t.status == "complete").length;
  int get totalCount => tasks.length;
}
