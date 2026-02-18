import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<String?> getFCMToken() async {
    // Request permissions for iOS and web platforms
    final notificationSettings = await _firebaseMessaging.requestPermission(
      provisional: true,
    );

    // Access the token
    String? token = await _firebaseMessaging.getToken();
    print("FCM Token: $token");

    // Optional: Send the token to your backend server for storage
    // sendTokenToServer(token);

    return token;
  }
}
