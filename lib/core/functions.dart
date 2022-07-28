import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastStates {
  success,
  error,
  warning,
}

void showToast({
  required String message,
  required ToastStates state,
}) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: _getToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

Color _getToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
  }

  return color;
}

String? validateField({
  required String title,
  required String? value,
  String message = 'can not be empty',
}) {
  if (value!.isEmpty) {
    return '$title $message';
  }
  return null;
}
