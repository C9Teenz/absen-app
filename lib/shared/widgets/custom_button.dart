// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.width,
    required this.icon,
    required this.color,
  }) : super(key: key);
  final String text;
  final Function() onPressed;
  final double width;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 46,
      child: ElevatedButton.icon(
        icon: Icon(
          icon,
          color: Colors.white,
        ),
        label: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: const StadiumBorder(),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
