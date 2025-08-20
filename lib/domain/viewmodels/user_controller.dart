import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  var name = ''.obs;
  var email = ''.obs;
  var photoUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  void fetchUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (doc.exists) {
        final data = doc.data();
        name.value = data?['displayName'] ?? '';
        email.value = data?['email'] ?? '';
        photoUrl.value = data?['avatarUrl'] ?? '';
      }
    }
  }
}
