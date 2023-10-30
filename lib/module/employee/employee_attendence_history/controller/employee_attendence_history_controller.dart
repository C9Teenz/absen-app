import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:absensi/core.dart';

class EmployeeAttendenceHistoryController
    extends State<EmployeeAttendenceHistoryView> {
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

  Stream<QuerySnapshot<Object?>>? datas =
      AttendanceServices().attendanceHistorySnapshot(date: DateTime.now());

  updateData({required DateTime date}) {
    datas = AttendanceServices().attendanceHistorySnapshot(date: date);
    setState(() {});
  }
}
