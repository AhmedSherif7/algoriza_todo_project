import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final int id;
  final int isCompleted;
  final String title;
  final String date;
  final String startTime;
  final String endTime;
  final int remindMinutes;
  final String repeat;
  final int isFavorite;
  final int color;
  final int hasNotifications;

  const Task({
    required this.id,
    required this.isCompleted,
    required this.title,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.remindMinutes,
    required this.repeat,
    required this.isFavorite,
    required this.color,
    required this.hasNotifications,
  });

  Task copyWith({
    int? id,
    int? isCompleted,
    String? title,
    String? date,
    String? startTime,
    String? endTime,
    int? remindMinutes,
    String? repeat,
    int? isFavorite,
    int? color,
    int? hasNotifications,
  }) {
    return Task(
      id: id ?? this.id,
      isCompleted: isCompleted ?? this.isCompleted,
      title: title ?? this.title,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      remindMinutes: remindMinutes ?? this.remindMinutes,
      repeat: repeat ?? this.repeat,
      isFavorite: isFavorite ?? this.isFavorite,
      color: color ?? this.color,
      hasNotifications: hasNotifications ?? this.hasNotifications,
    );
  }

  @override
  List<Object> get props => [
        id,
        isCompleted,
        title,
        date,
        startTime,
        endTime,
        remindMinutes,
        repeat,
        isFavorite,
        color,
        hasNotifications,
      ];
}
