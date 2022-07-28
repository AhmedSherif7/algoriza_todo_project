import 'package:algoriza_todo/presentation/managers/schedule/schedule_cubit.dart';
import 'package:algoriza_todo/presentation/resources/colors_manager.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DateTimeLine extends StatelessWidget {
  const DateTimeLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 14.0,
        horizontal: 16.0,
      ),
      child: DatePicker(
        monthTextStyle: const TextStyle(
          fontSize: 0,
        ),
        DateTime.now(),
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryColor,
        selectedTextColor: Colors.white,
        onDateChange: (date) {
          context.read<ScheduleCubit>().changeSelectedDate(date);
        },
      ),
    );
  }
}
