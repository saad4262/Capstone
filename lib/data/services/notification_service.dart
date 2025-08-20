import 'package:capstone/core/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AppNotificationService {
  static final FlutterLocalNotificationsPlugin _local =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    // Local notifications init
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);
    await _local.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (resp) async {
        // Optional: deep link / navigate
        Get.to(() => AppRoutes.task);
      },
    );

    // iOS permission (Android auto)
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Foreground messages -> show local notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final n = message.notification;
      if (n != null) {
        _local.show(
          n.hashCode,
          n.title ?? 'Task Update',
          n.body ?? '',
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'task_channel', 
              'Task Notifications',
              importance: Importance.max,
              priority: Priority.high,
            ),
          ),
          payload: message.data['taskId'],
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // final taskId = message.data['taskId'];
           Get.to(() => AppRoutes.task); 
    });
  }

  static Future<void> saveDeviceToken() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'email': user.email,
        'fcmToken': token,
      }, SetOptions(merge: true));
    }

    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'fcmToken': newToken,
      }, SetOptions(merge: true));
    });
  }
}
