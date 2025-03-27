import 'package:flutter/material.dart';
import 'package:app_intern/components/colors.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool textInvisible;
  final bool incorrect;
  final TextEditingController controller;

  const InputField({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.controller,
    this.incorrect = false,
    this.textInvisible = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: 8.0), // Increased spacing for better layout
      width: size.width * 0.9,
      height: 55,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: textInvisible,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color:
                Colors.grey.shade600,
          ),
          prefixIcon: Icon(
            icon,
            color: primaryColor,
          ),
          filled: true,
          fillColor: backgroundColor,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 10.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: incorrect ? Colors.red : Colors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: incorrect ? Colors.red : primaryColor,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
