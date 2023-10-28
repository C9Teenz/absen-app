import 'package:flutter/material.dart';
import 'package:absensi/core.dart';

class LoginController extends State<LoginView> {
  static late LoginController instance;
  late LoginView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  doHRDLogin(BuildContext context) async {
    try {
      await AuthServices().doHRDLogin();

      Get.offAll(const HrdMainNavigationView());
    } on Exception {
      showCustomDialog(dialog: "Unauthorized Access!");
    }
  }

  doEmployeeLogin(BuildContext context) async {
    try {
      await AuthServices().doEmployeeLogin();

      Get.offAll(const EmployeeMainNavigationView());
    } on Exception {
      showCustomDialog(dialog: "Unauthorized Access!");
    }
  }
}
