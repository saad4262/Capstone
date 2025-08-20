import 'package:capstone/model/authmodel/auth_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
   
  // Signup User
  // Future<Auth?> signUp(String email, String password, String name) async {
  //   final userCred = await _auth.createUserWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   );

  //   final newUser = Auth(
  //     userId: userCred.user!.uid,
  //     displayName: name,
  //     email: email,
  //     avatarUrl: '',
  //     createdAt: Timestamp.now(),
  //     updatedAt: Timestamp.now(),
  //   );

  //   await _firestore
  //       .collection('users')
  //       .doc(newUser.userId)
  //       .set(newUser.toFirestore());
  //   return newUser;
  // }

  Future<Auth?> signUp(
    String email,
    String password,
    String name, {
    String avatarUrl = '',
  }) async {
    final userCred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final newUser = Auth(
      userId: userCred.user!.uid,
      displayName: name,
      email: email,
      avatarUrl: avatarUrl,
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    );

    await _firestore
        .collection('users')
        .doc(newUser.userId)
        .set(newUser.toFirestore());
    return newUser;
  }

  Future<Auth?> login(String email, String password) async {
    final userCred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final doc = await _firestore
        .collection('users')
        .doc(userCred.user!.uid)
        .get();
    return Auth.fromFirestore(doc);
  }

   Future<void> logout() async {
    await _auth.signOut();
  }


   Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}


