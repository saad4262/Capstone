import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:capstone/model/taskmodel/task_model.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _taskCollection = FirebaseFirestore.instance
      .collection('tasks');

  Stream<List<Task>> getTasksByUser(String userId) {
    return _taskCollection
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Task.fromJson(doc.data() as Map<String, dynamic>))
              .toList(),
        );
  }

  Future<void> addTask(Task task) async {
    final doc = _taskCollection.doc(task.id.isEmpty ? null : task.id);
    await doc.set(task.toJson());
  }

  Future<void> updateTask(Task task) async {
    await _taskCollection.doc(task.id).update(task.toJson());
  }

  Future<void> deleteTask(String taskId) async {
    await _taskCollection.doc(taskId).delete();
  }
}
