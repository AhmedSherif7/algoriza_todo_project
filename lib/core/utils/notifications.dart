import 'package:algoriza_todo/core/constants.dart';
import 'package:algoriza_todo/core/di.dart';
import 'package:algoriza_todo/core/extensions.dart';
import 'package:algoriza_todo/data/data_sources/local_data_source.dart';
import 'package:algoriza_todo/domain/entities/task.dart';
import 'package:algoriza_todo/presentation/pages/board_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final flutterLocalNotificationsPlugin = di<FlutterLocalNotificationsPlugin>();

final localDataSource = di<LocalDataSource>();

Future<void> initNotifications(BuildContext context) async {
  AndroidInitializationSettings initializationSettingsAndroid =
      const AndroidInitializationSettings('appicon');

  IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
    requestAlertPermission: true,
    requestSoundPermission: true,
    requestBadgePermission: true,
    onDidReceiveLocalNotification: (id, title, body, payload) {
      onDidReceiveLocalNotification(
        id,
        title,
        body,
        payload,
        context,
      );
    },
  );

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onSelectNotification: (value) {
      selectNotification(
        value,
        context,
      );
    },
  );
}

Future<bool> scheduleNotification({
  required Task task,
}) async {
  tz.initializeTimeZones();

  if (_isTaskWillHaveNotifications(task)) {
    final nextNotificationTime = _getTaskRepeatRemind(task.repeat);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      task.id,
      task.title,
      'Do not forget to ${task.title}',
      tz.TZDateTime.from(_getTaskFirstNotificationDateTime(task), tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          kTasksNotificationChannelId,
          kTasksNotificationChannelName,
          channelDescription: kTasksNotificationChannelDescription,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: nextNotificationTime,
    );

    await localDataSource.setTaskNotification(task.id);

    return true;
  }
  return false;
}

DateTimeComponents? _getTaskRepeatRemind(String repeat) {
  switch (repeat) {
    case 'None':
      return null;
    case 'Daily':
      return DateTimeComponents.time;
    case 'Weekly':
      return DateTimeComponents.dayOfWeekAndTime;
    default:
      return DateTimeComponents.dayOfMonthAndTime; // Monthly
  }
}

bool _isTaskWillHaveNotifications(Task task) {
  if (task.remindMinutes == 0) {
    return false;
  }
  DateTime remindDateTime = _getTaskRemindDateTime(task);

  if (remindDateTime.isAfter(DateTime.now())) {
    return true;
  } else {
    if (task.repeat == 'None') {
      return false;
    }
    return true;
  }
}

DateTime _getTaskFirstNotificationDateTime(Task task) {
  DateTime remindDateTime = _getTaskRemindDateTime(task);

  if (remindDateTime.isAfter(DateTime.now())) {
    return remindDateTime;
  } else {
    switch (task.repeat) {
      case 'Daily':
        return remindDateTime.add(
          const Duration(days: 1),
        );
      case 'Weekly':
        return remindDateTime.add(
          const Duration(days: 7),
        );
      default:
        return remindDateTime.add(
          const Duration(days: 30),
        ); // Monthly
    }
  }
}

DateTime _getTaskRemindDateTime(Task task) {
  final taskTime = task.startTime.getTimeOfDay();
  final minutesRemind = _getMinutesBeforeTaskTime(task.remindMinutes);
  final remindDateTime = DateTime.parse(task.date)
      .add(
        Duration(hours: taskTime.hour, minutes: taskTime.minute),
      )
      .subtract(
        Duration(minutes: minutesRemind),
      );
  return DateTime.parse(
    DateFormat('yyyy-mm-dd hh:mm:ss').format(remindDateTime),
  );
}

int _getMinutesBeforeTaskTime(int remind) {
  switch (remind) {
    case 0:
      return 0;
    case 10:
      return 10;
    case 30:
      return 30;
    case 60:
      return 60;
    default:
      return 24 * 60; // one day
  }
}

Future<void> cancelTaskNotifications(int taskId) async {
  await flutterLocalNotificationsPlugin.cancel(taskId);
}

Future<void> cancelAllNotifications() async {
  await flutterLocalNotificationsPlugin.cancelAll();
}

Future<List<PendingNotificationRequest>> getPendingNotifications() async {
  return await flutterLocalNotificationsPlugin.pendingNotificationRequests();
}

// for older iOS versions older than 10
void onDidReceiveLocalNotification(
  int? id,
  String? title,
  String? body,
  String? payload,
  BuildContext context,
) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text(title ?? 'Title'),
        content: Text(body ?? 'Body'),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BoardPage(),
                ),
              );
            },
          )
        ],
      );
    },
  );
}

void selectNotification(String? payload, BuildContext context) async {
  if (payload != null) {
    debugPrint('notification payload: $payload');
  }
  await Navigator.push(
    context,
    MaterialPageRoute<void>(builder: (context) => const BoardPage()),
  );
}
