
import 'package:flutter/material.dart';
import 'package:absensi/core.dart';
import '../view/employee_attendence_history_view.dart';

class EmployeeAttendenceHistoryController extends State<EmployeeAttendenceHistoryView> {
    static late EmployeeAttendenceHistoryController instance;
    late EmployeeAttendenceHistoryView view;

    @override
    void initState() {
        instance = this;
        super.initState();
    }

    @override
    void dispose() => super.dispose();

    @override
    Widget build(BuildContext context) => widget.build(context, this);
}
        
    