import 'package:capstone/domain/viewmodels/darkmode_controller.dart';
import 'package:capstone/domain/viewmodels/task_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class TaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskController>(() => TaskController());
  }
}
