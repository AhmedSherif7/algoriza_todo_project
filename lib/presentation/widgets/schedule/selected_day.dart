import 'package:algoriza_todo/presentation/managers/schedule/schedule_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SelectedDay extends StatelessWidget {
  const SelectedDay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ScheduleCubit, ScheduleState, DateTime>(
      selector: (state) {
        return context.read<ScheduleCubit>().selectedDate;
      },
      builder: (context, date) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('EEEE').format(date),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22.0,
                ),
              ),
              Text(
                DateFormat('dd MMM, yyyy').format(date),
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
