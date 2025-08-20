import 'package:capstone/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// =====================
/// Notification Handling
/// =====================
class NotificationHandler {
  /// Initialize local notifications and request permissions
  static Future<void> init() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: androidInit);

    await flutterLocalNotificationsPlugin.initialize(settings);

    // Request FCM permissions
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Save device token to Firestore
    await saveDeviceTokenForCurrentUser();
  }

  /// Show a notification
  // static void showNotification(RemoteMessage message) {
  //   final notification = message.notification;
  //   if (notification == null) return;

  //   flutterLocalNotificationsPlugin.show(
  //     0,
  //     notification.title,
  //     notification.body,
  //     const NotificationDetails(
  //       android: AndroidNotificationDetails(
  //         'task_channel',
  //         'Task Notifications',
  //         importance: Importance.max,
  //         priority: Priority.high,
  //       ),
  //     ),
  //   );
  // }

  static void showNotification(RemoteMessage message) {
    String title =
        message.notification?.title ?? message.data['title'] ?? 'Task';
    String body =
        message.notification?.body ??
        message.data['body'] ??
        'You have a new task';

    flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'task_channel',
          'Task Notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }

  /// Show an in-app Snackbar
  static void showInAppSnackBar(
    RemoteMessage message,
    GlobalKey<NavigatorState> navigatorKey,
  ) {
    final notification = message.notification;
    if (notification == null) return;

    if (navigatorKey.currentState != null) {
      final ctx = navigatorKey.currentState!.overlay!.context;
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text('${notification.title}: ${notification.body}'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}

Future<void> removeTokenOnLogout() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  final token = await FirebaseMessaging.instance.getToken();
  if (token != null) {
    await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
      'fcmTokens': FieldValue.arrayRemove([token]),
    });
  }
}

/// =====================
/// Device Token Management
/// =====================
// class DeviceTokenManager {
//   /// Save current device FCM token
//   static Future<void> saveDeviceToken() async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) return;

//     // final token = await FirebaseMessaging.instance.getToken();
//     // if (token != null) {
//     //   print("FCM Token: $token");
//     //   await _saveTokenToFirestore(user.uid, user.email, token);
//     // }

//     final token = await FirebaseMessaging.instance.getToken();
//     if (token != null) {
//       await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
//         'email': user.email,
//         'fcmTokens': FieldValue.arrayUnion([token]),
//       }, SetOptions(merge: true));
//     }

//     // Listen for token refresh
//     FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
//       // print("FCM Token refreshed: $newToken");
//       // await _saveTokenToFirestore(user.uid, null, newToken);
//       await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
//         'fcmTokens': FieldValue.arrayUnion([newToken]),
//       }, SetOptions(merge: true));
//     });
//   }

// Future<void> saveDeviceTokenForCurrentUser() async {
//   final user = FirebaseAuth.instance.currentUser;
//   if (user == null) return;

//   final token = await FirebaseMessaging.instance.getToken();
//   if (token != null) {
//     await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
//       'email': user.email,
//       'fcmTokens': FieldValue.arrayUnion([token]),
//     }, SetOptions(merge: true));
//   }

//   // Listen for token refresh
//   FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
//     await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
//       'fcmTokens': FieldValue.arrayUnion([newToken]),
//     }, SetOptions(merge: true));
//   });

//   Future<void> printTokenByEmail(String email) async {
//     final snapshot = await FirebaseFirestore.instance
//         .collection('users')
//         .where('email', isEqualTo: email)
//         .get();

//     if (snapshot.docs.isEmpty) {
//       print("No user found with email: $email");
//       return;
//     }

//     final doc = snapshot.docs.first;
//     final tokens = doc['fcmTokens'];
//     print("FCM tokens for $email: $tokens");
//   }

//   /// Save token to Firestore
//   // static Future<void> _saveTokenToFirestore(
//   //   String uid,
//   //   String? email,
//   //   String token,
//   // ) async {
//   //   final data = {'fcmToken': token};
//   //   if (email != null) data['email'] = email;

//   //   await FirebaseFirestore.instance
//   //       .collection('users')
//   //       .doc(uid)
//   //       .set(data, SetOptions(merge: true));
//   // }
// }


Future<void> saveDeviceTokenForCurrentUser() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  final token = await FirebaseMessaging.instance.getToken();
  if (token != null) {
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'email': user.email,
      'fcmTokens': FieldValue.arrayUnion([token]),
    }, SetOptions(merge: true));
  }

  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'fcmTokens': FieldValue.arrayUnion([newToken]),
    }, SetOptions(merge: true));
  });
}

// Top-level function
Future<void> printTokenByEmail(String email) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: email)
      .get();

  if (snapshot.docs.isEmpty) {
    print("No user found with email: $email");
    return;
  }

  final doc = snapshot.docs.first;
  final tokens = doc['fcmTokens'];
  print("FCM tokens for $email: $tokens");
}
