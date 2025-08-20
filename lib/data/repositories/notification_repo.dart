  import 'dart:convert';

import 'package:http/http.dart' as http;

Future<void> sendTaskNotification(String fcmToken, String message) async {
    final url = Uri.parse(
      "https://us-central1-capstone-d4456.cloudfunctions.net/sendTaskNotification",
    );

    final res = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({"fcmToken": fcmToken, "message": message}),
    );

    print("Notification Response: ${res.body}");
  }

