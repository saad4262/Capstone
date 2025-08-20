import 'package:capstone/model/authmodel/auth_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch current user
  Future<Auth?> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final doc = await _firestore.collection('users').doc(user.uid).get();
    return Auth.fromFirestore(doc);
  }

  // Update user data
  Future<void> updateProfile({
    required String userId,
    String? displayName,
    String? avatarUrl,
    String? email,
  }) async {
    final data = <String, dynamic>{};
    if (displayName != null) data['displayName'] = displayName;
    if (avatarUrl != null) data['avatarUrl'] = avatarUrl;
    if (email != null) data['email'] = email;

    if (data.isNotEmpty) {
      await _firestore.collection('users').doc(userId).update(data);
    }
  }

  // Update FirebaseAuth email
  Future<void> updateAuthEmail(String newEmail, String currentPassword) async {
    final user = _auth.currentUser;
    if (user != null) {
      // Reauthenticate
      final cred = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );
      await user.reauthenticateWithCredential(cred);

      // Now update email
      await user.verifyBeforeUpdateEmail(newEmail);
    }
  }

  // Update FirebaseAuth password
  Future<void> updatePassword(
    String newPassword,
    String currentPassword,
  ) async {
    final user = _auth.currentUser;
    if (user != null) {
      final cred = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );
      await user.reauthenticateWithCredential(cred);

      await user.updatePassword(newPassword);
    }
  }
}
