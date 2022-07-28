import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension TaskEx on int {
  Color getTaskColor() {
    switch (this) {
      case 0:
        return const Color(0xffFF5147);
      case 1:
        return const Color(0xffFF9D42);
      case 2:
        return const Color(0xffF9C50B);
      default:
        return const Color(0xff42A0FF);
    }
  }

  String getTaskReminderMinutes() {
    switch (this) {
      case 0:
        return 'None';
      case 5:
        return '5 minutes early';
      case 10:
        return '10 minutes early';
      case 30:
        return '30 minutes early';
      case 60:
        return '1 hour early';
      default:
        return '1 day early';
    }
  }

  bool isTaskCompleted() {
    return this == 1;
  }

  bool isTaskFavorite() {
    return this == 1;
  }
}

extension FormtDateAndTimeFromString on String {
  String formatDate() {
    return DateFormat('dd-MMM-yyyy').format(DateTime.parse(this));
  }

  TimeOfDay getTimeOfDay() {
    final hours = substring(10, 12);
    final minutes = substring(13, 15);

    return TimeOfDay(hour: int.parse(hours), minute: int.parse(minutes));
  }

  String getTimeOfDayString() {
    final hours = substring(10, 12);
    final minutes = substring(13, 15);

    return '$hours:$minutes';
  }
}

extension FormtDateFromDateTime on DateTime {
  String formatDate() {
    return DateFormat('dd-MMM-yyyy').format(this);
  }
}

extension FormatTaskTime on TimeOfDay {
  String formatTime() {
    var result = '';

    if (hour.toString().length < 2) {
      result += '0${hour.toString()}';
    } else {
      result += hour.toString();
    }

    if (minute.toString().length < 2) {
      result += ':0${minute.toString()}';
    } else {
      result += ':${minute.toString()}';
    }

    return result;
  }
}
