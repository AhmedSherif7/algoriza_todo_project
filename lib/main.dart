import 'package:algoriza_todo/core/di.dart';
import 'package:algoriza_todo/presentation/managers/bloc_observer.dart';
import 'package:algoriza_todo/presentation/pages/board_page.dart';
import 'package:algoriza_todo/presentation/resources/themes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();

  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      home: const BoardPage(),
    );
  }
}
