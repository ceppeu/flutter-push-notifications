import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

//cOsgP6XjTP2qFZZn6-osGX:APA91bHZ30xfVMgIIwZedLAD0npuRQRTojRtlv1K-ATWsTKA8MakNAlnwPUkx4toLMD_twAyOwV2yDNXYky9mR19Y35WFD-S-OGm_mPfkFO_s5DP4EzTar4BBpb1zW3xwQVjIxMKfLB6

class PushNotificationsProvider {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _messageStreamController = StreamController<String>.broadcast();

  Stream<String> get messageStream => _messageStreamController.stream;

  static Future<dynamic> onBackgroundMessage(
      Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }
    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }
  }

  initNotifications() async {
    await _firebaseMessaging.requestNotificationPermissions();
    final token = await _firebaseMessaging.getToken();
    print('========= FCM TOKEN =======');
    print(token);

    _firebaseMessaging.configure(
        onMessage: onMessage,
        onBackgroundMessage: onBackgroundMessage,
        onLaunch: onLaunch,
        onResume: onResume);
  }

  Future<dynamic> onMessage(Map<String, dynamic> message) async {
    print('======= ON MESSAGE =======');
    final arg = message['data']['comida'] ?? 'no-data';
    _messageStreamController.sink.add(arg);
  }

  Future<dynamic> onLaunch(Map<String, dynamic> message) async {
    print('======= ON LAUNCH =======');
    final arg = message['data']['comida'] ?? 'no-data';
    _messageStreamController.sink.add(arg);
  }

  Future<dynamic> onResume(Map<String, dynamic> message) async {
    print('======= ON RESUME =======');
    final arg = message['data']['comida'] ?? 'no-data';
    _messageStreamController.sink.add(arg);
  }

  dispose() {
    _messageStreamController?.close();
  }
}
