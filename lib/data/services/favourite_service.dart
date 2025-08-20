// lib/data/services/task_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:capstone/model/taskmodel/task_model.dart';

class FavouriteTaskService {
  final CollectionReference _taskCollection =
      FirebaseFirestore.instance.collection('tasks');

  Stream<List<Task>> getTasksByUser(String userId) {
    return _taskCollection
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Task.fromJson(doc.data() as Map<String, dynamic>)).toList());
  }

  Stream<List<Task>> getFavouriteTasks(String userId) {
    return _taskCollection
        .where('favouriteByUsers', arrayContains: userId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Task.fromJson(doc.data() as Map<String, dynamic>)).toList());
  }

  Future<void> toggleFavourite(String taskId, String userId, bool isFav) async {
    final docRef = _taskCollection.doc(taskId);

    if (isFav) {
      // agar already fav hai to remove karo
      await docRef.update({
        'favouriteByUsers': FieldValue.arrayRemove([userId])
      });
    } else {
      // agar fav nahi hai to add karo
      await docRef.update({
        'favouriteByUsers': FieldValue.arrayUnion([userId])
      });
    }
  }
}
