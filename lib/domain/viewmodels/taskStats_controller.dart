import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskStatsController extends GetxController {
  var inProgressCount = 0.obs;
  var pendingCount = 0.obs;
  var acceptedCount = 0.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final currentid = FirebaseAuth.instance.currentUser?.uid;

  @override
  void onInit() {
    super.onInit();
    _listenToTaskStats();
  }

  void _listenToTaskStats() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    FirebaseFirestore.instance
        .collection('tasks')
        .where('userId', isEqualTo: currentid) 
        .snapshots()
        .listen((snapshot) {
      int inProgress = 0;
      int pending = 0;
      int accepted = 0;

      for (var doc in snapshot.docs) {
        String status = doc['status'] ?? '';
        if (status == 'review') inProgress++;
        if (status == 'pending') pending++;
        if (status == 'complete') accepted++;
      }

      inProgressCount.value = inProgress;
      pendingCount.value = pending;
      acceptedCount.value = accepted;
    });
  }
}
