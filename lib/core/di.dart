import 'package:algoriza_todo/core/constants.dart';
import 'package:algoriza_todo/data/data_sources/local_data_source.dart';
import 'package:algoriza_todo/data/repositories/task_repository_impl.dart';
import 'package:algoriza_todo/domain/repositories/task_repository.dart';
import 'package:algoriza_todo/domain/use_cases/add_task_to_favorites_use_case.dart';
import 'package:algoriza_todo/domain/use_cases/cancel_all_notifications_use_case.dart';
import 'package:algoriza_todo/domain/use_cases/complete_task_use_case.dart';
import 'package:algoriza_todo/domain/use_cases/create_task_use_case.dart';
import 'package:algoriza_todo/domain/use_cases/delete_task_use_case.dart';
import 'package:algoriza_todo/domain/use_cases/get_all_tasks_use_case.dart';
import 'package:algoriza_todo/domain/use_cases/remove_task_from_favorites_use_case.dart';
import 'package:algoriza_todo/domain/use_cases/remove_task_notifications_use_case.dart';
import 'package:algoriza_todo/domain/use_cases/set_task_notifications_use_case.dart';
import 'package:algoriza_todo/domain/use_cases/un_complete_task_use_case.dart';
import 'package:algoriza_todo/presentation/managers/create_task/create_task_cubit.dart';
import 'package:algoriza_todo/presentation/managers/schedule/schedule_cubit.dart';
import 'package:algoriza_todo/presentation/managers/task/task_cubit.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

final di = GetIt.instance;

Future<void> initAppModule() async {
  final database = await initDatabase();

  // external
  di.registerLazySingleton<Database>(() => database);
  di.registerLazySingleton<FlutterLocalNotificationsPlugin>(
    () => FlutterLocalNotificationsPlugin(),
  );

  // data source
  di.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(database));

  // repository
  di.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(di()));

  // use cases
  di.registerLazySingleton<GetAllTasksUseCase>(() => GetAllTasksUseCase(di()));
  di.registerLazySingleton<CreateTaskUseCase>(() => CreateTaskUseCase(di()));
  di.registerLazySingleton<CompleteTaskUseCase>(
      () => CompleteTaskUseCase(di()));
  di.registerLazySingleton<UnCompleteTaskUseCase>(
      () => UnCompleteTaskUseCase(di()));
  di.registerLazySingleton<AddTaskToFavoritesUseCase>(
      () => AddTaskToFavoritesUseCase(di()));
  di.registerLazySingleton<RemoveTaskFromFavoritesUseCase>(
      () => RemoveTaskFromFavoritesUseCase(di()));
  di.registerLazySingleton<DeleteTaskUseCase>(() => DeleteTaskUseCase(di()));
  di.registerLazySingleton<SetTaskNotificationsUseCase>(
      () => SetTaskNotificationsUseCase(di()));
  di.registerLazySingleton<RemoveTaskNotificationsUseCase>(
      () => RemoveTaskNotificationsUseCase(di()));
  di.registerLazySingleton<CancelAllNotificationsUseCase>(
      () => CancelAllNotificationsUseCase(di()));

  // blocs
  di.registerFactory<TaskCubit>(
    () => TaskCubit(
      di(),
      di(),
      di(),
      di(),
      di(),
      di(),
      di(),
      di(),
      di(),
    ),
  );

  di.registerFactory<CreateTaskCubit>(
    () => CreateTaskCubit(
      di(),
    ),
  );

  di.registerFactory<ScheduleCubit>(
    () => ScheduleCubit(
      di(),
    ),
  );
}

Future<Database> initDatabase() async {
  var databasesPath = await getDatabasesPath();
  String path = '$databasesPath$kTasksDB';

  final database = await openDatabase(
    path,
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute(
        'CREATE TABLE $kTasksTable (id INTEGER PRIMARY KEY, title TEXT, isCompleted INTEGER, date Text,'
        ' startTime TEXT, endTime TEXT, remindMinutes INTEGER, repeat TEXT,'
        ' isFavorite INTEGER, color INTEGER, hasNotifications INTEGER)',
      );
    },
  );

  return database;
}
