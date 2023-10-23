import 'dart:async';

import 'package:absensi/services/attendance_services.dart';
import 'package:absensi/services/device_info_service.dart';
import 'package:absensi/services/location_services.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:absensi/core.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import '../view/employee_attendence_view.dart';

class EmployeeAttendenceController extends State<EmployeeAttendenceView> {
  static late EmployeeAttendenceController instance;
  late EmployeeAttendenceView view;
  late Timer timer;

  @override
  void initState() {
    instance = this;
    getUserData();
    getTime();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
  Position? position;
  String? deviceModel;
  String? deviceId;
  String? photoUrl;
  getUserData() async {
    await getLocation();
    await getDeviceInfo();
    setState(() {});
  }

  getLocation() async {
    position = await LocationService().getLocation();
  }

  getDeviceInfo() async {
    AndroidDeviceInfo androidInfo=await DeviceInfoService().getDeviceInfo();
    deviceModel = androidInfo.model;
    deviceId = androidInfo.id;
  }

  String time = "";
  String dateString = "";

  getTime() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      DateTime date = DateTime.now();
      time = DateFormat("HH:mm:ss").format(date);
      dateString = DateFormat("d MMMM y").format(date);

      setState(() {});
    });
  }

  doCheckIn() async {
    await AttendanceServices().checkIn(
        photoUrl: photoUrl!,
        deviceModel: deviceModel!,
        deviceid: deviceId!,
        latitude: position!.latitude,
        longitude: position!.longitude,
        time: time);
  }
  doCheckOut()async{
    await AttendanceServices().checkOut(latitude: position!.latitude,longitude: position!.longitude,photoUrl: photoUrl!);
  }
}
