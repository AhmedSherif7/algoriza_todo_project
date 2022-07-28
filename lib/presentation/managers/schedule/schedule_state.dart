part of 'schedule_cubit.dart';

@immutable
abstract class ScheduleState {}

class ScheduleInitial extends ScheduleState {}

class ScheduleTaskLoadingState extends ScheduleState {}

class ScheduleTaskErrorState extends ScheduleState {
  final String error;

  ScheduleTaskErrorState(this.error);
}

class ScheduleTaskSuccessState extends ScheduleState {}

class SelectedDateChange extends ScheduleState {}
