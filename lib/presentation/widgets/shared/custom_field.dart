import 'package:algoriza_todo/presentation/resources/colors_manager.dart';
import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  const CustomField({
    Key? key,
    required this.title,
    required this.hint,
    this.validator,
    required this.controller,
    this.readOnly = false,
    this.suffixOnPressed,
    this.suffixIcon,
  }) : super(key: key);

  final String title;
  final String hint;
  final String? Function(String? value)? validator;
  final TextEditingController controller;
  final bool readOnly;
  final VoidCallback? suffixOnPressed;
  final IconData? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(12, 12, 0, 12),
          decoration: BoxDecoration(
            color: textFieldBackground,
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: TextFormField(
            controller: controller,
            validator: validator,
            cursorColor: primaryColor,
            readOnly: readOnly,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: const TextStyle(
                color: Colors.grey,
              ),
              suffixIcon: IconButton(
                onPressed: suffixOnPressed,
                icon: Icon(
                  suffixIcon,
                  color: Colors.grey,
                ),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
