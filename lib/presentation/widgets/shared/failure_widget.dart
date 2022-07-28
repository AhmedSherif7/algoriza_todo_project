import 'package:flutter/material.dart';

class FailureWidget extends StatelessWidget {
  const FailureWidget(this.error, {Key? key}) : super(key: key);

  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(error),
    );
  }
}
