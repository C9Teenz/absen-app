
import 'package:flutter/material.dart';
import 'package:absensi/core.dart';
import '../controller/employee_attendence_history_controller.dart';

class EmployeeAttendenceHistoryView extends StatefulWidget {
    const EmployeeAttendenceHistoryView({Key? key}) : super(key: key);

    Widget build(context, EmployeeAttendenceHistoryController controller) {
    controller.view = this;

    return Scaffold(
        appBar: AppBar(
        title: const Text("EmployeeAttendenceHistory"),
        actions: const [],
        ),
        body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
            children: const [],
            ),
        ),
        ),
    );
    }

    @override
    State<EmployeeAttendenceHistoryView> createState() => EmployeeAttendenceHistoryController();
}
    