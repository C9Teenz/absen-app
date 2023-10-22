// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class CustomItemNavBar extends StatelessWidget {
  const CustomItemNavBar({
    Key? key,
    required this.title,
    required this.icon,
    required this.index,
    required this.ontap,
    required this.selectedIndex,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final int index;
  final Function() ontap;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => ontap(),
      child: Column(
        children: [
          Icon(
            icon,
            size: 24.0,
            color: selectedIndex == index
                ? const Color(0xff017aff)
                : Colors.grey[500],
          ),
          Text(
            title,
            style: TextStyle(
                color: selectedIndex == index
                    ? const Color(0xff017aff)
                    : Colors.grey[500]),
          )
        ],
      ),
    );
  }
}
