import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void >handleBackgroundMessage (RemoteMessage message) async{
  if (message.notification != null) {
    print('title: ${message.notification!.title}');
    print('body: ${message.notification!.body}');
  }


}
class FirebaseApi{
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _androidChannel=const AndroidNotificationChannel('high_importance_channel', 'High Importance Notification', description: 'This Channel is used for notification', importance: Importance.high);
  final _localNotification=FlutterLocalNotificationsPlugin();


  Future initPushNotification() async{
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true
    );

   // FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
  }

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('Token $fCMToken');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification=message.notification;
      if(notification==null)return;


      _localNotification.show(notification.hashCode, notification.title, notification.body,
      NotificationDetails(android: AndroidNotificationDetails(
        _androidChannel.id,
        _androidChannel.name,
        channelDescription: _androidChannel.description,
         icon: '@drawable/flutter_logo'
      )),
        payload: jsonEncode(message.toMap())
      );
    });
  }



}