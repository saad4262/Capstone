// lib/data/repositories/task_repo.dart
import 'package:capstone/data/services/favourite_service.dart';
import 'package:capstone/model/taskmodel/task_model.dart';

class FavouriteTaskRepository {
  final FavouriteTaskService _service = FavouriteTaskService();

  Stream<List<Task>> getTasksByUser(String userId) => _service.getTasksByUser(userId);

  Stream<List<Task>> getFavouriteTasks(String userId) => _service.getFavouriteTasks(userId);

  Future<void> toggleFavourite(String taskId, String userId, bool isFav) =>
      _service.toggleFavourite(taskId, userId, isFav);
}
