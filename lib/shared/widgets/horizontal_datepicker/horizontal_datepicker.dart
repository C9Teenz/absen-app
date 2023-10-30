// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class HorizontalDatePicker extends StatefulWidget {
  final Function(DateTime date)  onChanged;
  const HorizontalDatePicker({
    Key? key,
    required this.onChanged,
  }) : super(key: key);
  @override
  State<HorizontalDatePicker> createState() => _HorizontalDatePickerState();
}

class _HorizontalDatePickerState extends State<HorizontalDatePicker> {
  late DateTime currentDate;
  List getDates() {
    dateList = [];
    DateTime now = DateTime.now();
    DateTime startDate = now.subtract(const Duration(days: 2));
    for (int i = 0; i < 6; i++) {
      dateList.add(startDate.add(Duration(days: i)));
    }
    currentDate = dateList[2];
    return dateList;
  }

  List dateList = [];

  @override
  void initState() {
    getDates();
    super.initState();
  }

  updateSelectedDate(DateTime date) {
    currentDate = date;
    widget.onChanged(date);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
          children: List.generate(dateList.length, (index) {
        String day = dateList[index].day.toString();
        bool isToday = index == 2;
        bool isClicked = currentDate == dateList[index];
        return Expanded(
          child: InkWell(
            onTap: () {
              updateSelectedDate(dateList[index]);
              print(currentDate.toString());
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: isToday
                      ? const Color(0xfff6f7f6)
                      : isClicked
                          ? const Color(0xfff6f7f6)
                          : null),
              child: Center(
                child: Text(
                  isToday ? "Today" : day,
                  style: TextStyle(
                      color: isToday
                          ? Colors.blue[300]
                          : isClicked
                              ? Colors.blue[300]
                              : const Color(0xffbebebe),
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ),
            ),
          ),
        );
      })),
    );
  }
}
