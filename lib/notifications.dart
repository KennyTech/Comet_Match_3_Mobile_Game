import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications {
  final channelId = 'gameNotifications';
  final channelName = 'Game Notifications';
  final channelDescription = 'Game Notifications Channel';

  BuildContext _context;

  var _flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
  NotificationDetails _platformChannelInfo;
  var _notificationId = 100;

  void init(BuildContext context) {
    this._context = context;

    var initializationSettingsAndroid = new AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification
    );
    var initializationSettings = new InitializationSettings(
      initializationSettingsAndroid,
      initializationSettingsIOS
    );
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: onSelectNotification
    );

    var androidPlatformChannelInfo = AndroidNotificationDetails(
      channelId, 
      channelName,
      channelDescription,
      importance: Importance.Max,
      priority: Priority.High,
      ticker: 'ticker'
    );

    var iOSPlatformChannelInfo = IOSNotificationDetails();
    _platformChannelInfo = NotificationDetails(
      androidPlatformChannelInfo,
      iOSPlatformChannelInfo
    );
  }

  Future<dynamic> onDidReceiveLocalNotification(int id, String title, String body, String payload) {
    return null;
  }

  Future onSelectNotification(var payload) async {
    if(payload != null) {
      print('notification payload: ' + payload);
    }

    // ... redirect to some part of the app, using payload to view correct data item ...

    // await Navigator.push(
    //   this._context,
    //   new MaterialPageRoute(builder: (context) => ),
    // );
  }

  // if user no longer wants to receive notifications
  void cancelNotification(int id) {
    _flutterLocalNotificationsPlugin.cancel(id);
  }

  // for test console, 10 second later notification
  Future<void> sendNotificationNow(String title, String body, String payload) async {
    await _flutterLocalNotificationsPlugin.show(
      _notificationId++, 
      title, 
      body, 
      _platformChannelInfo,
      payload: payload
    );
    // return _notificationId;
  }

  Future<void> sendNotificationLater(String title, String body, DateTime when, String payload) async {
    await _flutterLocalNotificationsPlugin.schedule(
      _notificationId++, 
      title, 
      body, 
      when, 
      _platformChannelInfo
    );
    // return _notificationId;
  }

  // daily login bonus
    Future<int> sendNotificationDaily(int notificationId, String title, String body, Time time, String payload) async {
    await _flutterLocalNotificationsPlugin.showDailyAtTime(
      notificationId, 
      title, 
      body, 
      time, 
      _platformChannelInfo
    );
    return notificationId;
  }

  // Future<int> sendNotificationWeekly(int notificationId, String title, String body, Day day, Time time, String payload) async {
  //   await _flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
  //     notificationId, 
  //     title, 
  //     body, 
  //     day,
  //     time, 
  //     _platformChannelInfo
  //   );
  //   return notificationId;
  // }

}