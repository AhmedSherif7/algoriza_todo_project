import 'package:algoriza_todo/core/di.dart';
import 'package:algoriza_todo/core/extensions.dart';
import 'package:algoriza_todo/core/functions.dart';
import 'package:algoriza_todo/presentation/managers/create_task/create_task_cubit.dart';
import 'package:algoriza_todo/presentation/managers/task/task_cubit.dart';
import 'package:algoriza_todo/presentation/widgets/create_task/task_color_picker.dart';
import 'package:algoriza_todo/presentation/widgets/create_task/task_remind_options_dialog.dart';
import 'package:algoriza_todo/presentation/widgets/create_task/task_repeat_options_dialog.dart';
import 'package:algoriza_todo/presentation/widgets/shared/custom_button.dart';
import 'package:algoriza_todo/presentation/widgets/shared/custom_field.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({Key? key}) : super(key: key);

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();
  final _remindController = TextEditingController();
  final _repeatController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    _remindController.dispose();
    _repeatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<CreateTaskCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Task'),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: BlocConsumer<CreateTaskCubit, CreateTaskState>(
          listener: (context, state) {
            final cubit = BlocProvider.of<CreateTaskCubit>(context);

            if (state is CreateTaskErrorState) {
              showToast(
                message: state.error,
                state: ToastStates.error,
              );
            } else if (state is CreateTaskSuccessState) {
              showToast(
                message: 'Task created successfully',
                state: ToastStates.success,
              );
              context.read<TaskCubit>().changeAllTasks(state.task);
              Navigator.pop(context);
            }

            if (state is TaskDateChangeState) {
              _dateController.text =
                  DateFormat('yyyy-MM-dd').format(cubit.taskDate).toString();
            } else if (state is TaskStartTimeChangeState) {
              _startTimeController.text = cubit.taskStartTime.formatTime();
            } else if (state is TaskEndTimeChangeState) {
              _endTimeController.text = cubit.taskEndTime.formatTime();
            } else if (state is TaskRemindChangeState) {
              _remindController.text = context
                  .read<CreateTaskCubit>()
                  .taskRemind
                  .getTaskReminderMinutes();
            } else if (state is TaskRepeatChangeState) {
              _repeatController.text =
                  context.read<CreateTaskCubit>().taskRepeat;
            }
          },
          builder: (context, state) {
            return ConditionalBuilder(
              condition: state is CreateTaskLoadingState,
              builder: (context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              fallback: (context) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: context.read<CreateTaskCubit>().formKey,
                      child: Column(
                        children: [
                          CustomField(
                            title: 'Title',
                            hint: 'Task title',
                            controller: _titleController,
                            validator: (value) {
                              return validateField(
                                title: 'Title',
                                value: value,
                              );
                            },
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          CustomField(
                            title: 'Date',
                            hint: 'eg: 2022-01-01',
                            controller: _dateController,
                            readOnly: true,
                            validator: (value) {
                              return validateField(
                                title: 'Date',
                                value: value,
                              );
                            },
                            suffixOnPressed: () {
                              FocusScope.of(context).unfocus();
                              showDatePicker(
                                context: context,
                                initialDate:
                                    context.read<CreateTaskCubit>().taskDate,
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(
                                  const Duration(days: 365 * 5),
                                ),
                              ).then((value) {
                                context
                                    .read<CreateTaskCubit>()
                                    .changeTaskDate(value);
                              });
                            },
                            suffixIcon: Icons.calendar_today,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CustomField(
                                  title: 'Start Time',
                                  hint: '11:00',
                                  controller: _startTimeController,
                                  readOnly: true,
                                  validator: (value) {
                                    return validateField(
                                      title: 'Start time',
                                      value: value,
                                      message: 'is required',
                                    );
                                  },
                                  suffixOnPressed: () {
                                    FocusScope.of(context).unfocus();
                                    showTimePicker(
                                      context: context,
                                      initialTime: context
                                          .read<CreateTaskCubit>()
                                          .taskStartTime,
                                    ).then((value) {
                                      context
                                          .read<CreateTaskCubit>()
                                          .changeTaskStartTime(value);
                                    });
                                  },
                                  suffixIcon: Icons.watch_later_outlined,
                                ),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              Expanded(
                                child: CustomField(
                                  title: 'End Time',
                                  hint: '14:00',
                                  controller: _endTimeController,
                                  readOnly: true,
                                  validator: (value) {
                                    return validateField(
                                      title: 'End time',
                                      value: value,
                                      message: 'is required',
                                    );
                                  },
                                  suffixOnPressed: () {
                                    FocusScope.of(context).unfocus();
                                    showTimePicker(
                                      context: context,
                                      initialTime: context
                                          .read<CreateTaskCubit>()
                                          .taskStartTime,
                                    ).then((value) {
                                      context
                                          .read<CreateTaskCubit>()
                                          .changeTaskEndTime(value);
                                    });
                                  },
                                  suffixIcon: Icons.watch_later_outlined,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          CustomField(
                            title: 'Remind',
                            hint: 'None',
                            controller: _remindController,
                            suffixIcon: Icons.alarm_add_outlined,
                            readOnly: true,
                            validator: (value) {
                              return validateField(
                                title: 'Reminder',
                                value: value,
                              );
                            },
                            suffixOnPressed: () {
                              FocusScope.of(context).unfocus();
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return BlocProvider.value(
                                    value: context.read<CreateTaskCubit>(),
                                    child: const TaskRemindOptionsDialog(),
                                  );
                                },
                              );
                            },
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          CustomField(
                            title: 'Repeat',
                            hint: 'None',
                            controller: _repeatController,
                            suffixIcon: Icons.repeat,
                            readOnly: true,
                            validator: (value) {
                              return validateField(
                                title: 'Repeat',
                                value: value,
                              );
                            },
                            suffixOnPressed: () {
                              FocusScope.of(context).unfocus();
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return BlocProvider.value(
                                    value: context.read<CreateTaskCubit>(),
                                    child: const TaskRepeatOptionsDialog(),
                                  );
                                },
                              );
                            },
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          const TaskColorPicker(),
                          const SizedBox(
                            height: 50.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
        bottomSheet: Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
          child: Builder(
            builder: (context) {
              return CustomButton(
                text: 'Create a task',
                onPressed: () {
                  context
                      .read<CreateTaskCubit>()
                      .createTask(title: _titleController.text);
                },
                textColor: Colors.white,
              );
            },
          ),
        ),
      ),
    );
  }
}
