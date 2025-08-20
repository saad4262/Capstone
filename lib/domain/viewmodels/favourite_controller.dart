
import 'package:capstone/data/repositories/favourite_repo.dart';
import 'package:get/get.dart';
import 'package:capstone/model/taskmodel/task_model.dart';


class FavouriteTaskController extends GetxController {
  final FavouriteTaskRepository _repository = FavouriteTaskRepository();

  var tasks = <Task>[].obs;             
  var favouriteTasks = <Task>[].obs;    
  var isLoading = false.obs;

  void loadTasks(String userId) {
    isLoading.value = true;
    _repository.getTasksByUser(userId).listen((data) {
      tasks.value = data;
      isLoading.value = false;
      _updateFavourites(userId); 
    });
  }

  void loadFavourites(String userId) {
    _repository.getFavouriteTasks(userId).listen((data) {
      favouriteTasks.value = data;
    });
  }

  void toggleFavourite(Task task, String userId) async {
    final isFav = task.favouriteByUsers.contains(userId);

    await _repository.toggleFavourite(task.id, userId, isFav);

    if (isFav) {
      task.favouriteByUsers.remove(userId);
      favouriteTasks.removeWhere((t) => t.id == task.id);
    } else {
      task.favouriteByUsers.add(userId);
      favouriteTasks.add(task);
    }

    tasks.refresh();
    favouriteTasks.refresh();
  }

  bool isFavourite(Task task, String userId) {
    return task.favouriteByUsers.contains(userId);
  }

  void _updateFavourites(String userId) {
    favouriteTasks.value = tasks.where((t) => t.favouriteByUsers.contains(userId)).toList();
  }
}

