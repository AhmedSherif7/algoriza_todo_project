import 'package:algoriza_todo/presentation/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyTasksList extends StatelessWidget {
  const EmptyTasksList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'No Tasks !!',
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          Lottie.asset(
            emptyTasksListJson,
            repeat: false,
            height: 400,
          ),
        ],
      ),
    );
  }
}
