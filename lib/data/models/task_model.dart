import 'package:algoriza_todo/domain/entities/task.dart';

class TaskModel extends Task {
  const TaskModel({
    required super.id,
    required super.isCompleted,
    required super.title,
    required super.date,
    required super.startTime,
    required super.endTime,
    required super.remindMinutes,
    required super.repeat,
    required super.isFavorite,
    required super.color,
    required super.hasNotifications,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as int? ?? 0,
      isCompleted: json['isCompleted'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      date: json['date'] as String? ?? '',
      startTime: json['startTime'] as String? ?? '',
      endTime: json['endTime'] as String? ?? '',
      remindMinutes: json['remindMinutes'] as int? ?? 0,
      repeat: json['repeat'] as String? ?? '',
      isFavorite: json['isFavorite'] as int? ?? 0,
      color: json['color'] as int? ?? 0,
      hasNotifications: json['hasNotifications'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isCompleted': isCompleted,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'remindMinutes': remindMinutes,
      'repeat': repeat,
      'isFavorite': isFavorite,
      'color': color,
      'hasNotifications': hasNotifications,
    };
  }
}
