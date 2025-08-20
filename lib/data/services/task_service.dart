import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:capstone/model/taskmodel/task_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskService {
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _tasksCol = FirebaseFirestore.instance.collection(
    'tasks',
  );
  final CollectionReference _usersCol = FirebaseFirestore.instance.collection(
    'users',
  );

  // Get tasks for a specific user
  Stream<List<Task>> getTasksByUser(String userId) {
    return _tasksCol
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map(
          (snap) => snap.docs
              .map((doc) => Task.fromJson(doc.data() as Map<String, dynamic>))
              .toList(),
        );
  }

  Stream<List<Task>> getTasksStream() {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return Stream.value([]);
    }

    return _tasksCol
        .where('userId', isEqualTo: currentUser.uid)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>?;
            return Task.fromJson({if (data != null) ...data, 'id': doc.id});
          }).toList();
        });
  }

  // Add task with assigned user's FCM tokens
  Future<void> addTask(Task task) async {
    // Fetch FCM tokens for assigned user
    final snap = await _usersCol
        .where(
          'email',
          isEqualTo: task.assignedToUserEmail.toLowerCase().trim(),
        )
        .limit(1)
        .get();

    final tokens = snap.docs.isNotEmpty
        ? (snap.docs[0].data() as Map<String, dynamic>)['fcmTokens'] ?? []
        : [];

    final taskWithTokens = task.copyWith(
      assignedUserTokens: List<String>.from(tokens),
    );

    final doc = _tasksCol.doc(task.id.isEmpty ? null : task.id);
    await doc.set(taskWithTokens.toJson());
  }

  Future<void> updateTask(Task task) async {
    await _tasksCol.doc(task.id).update(task.toJson());
  }

  // Update multiple tasks positions
  Future<void> updateTaskPositions(List<Task> tasks) async {
    final batch = FirebaseFirestore.instance.batch();

    for (var task in tasks) {
      final docRef = _tasksCol.doc(task.id);
      batch.update(docRef, {'position': task.position});
    }

    await batch.commit();
  }

  // Delete task
  Future<void> deleteTask(String taskId) async {
    await _tasksCol.doc(taskId).delete();
  }
}
