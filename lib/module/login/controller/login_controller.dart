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

      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HrdMainNavigationView(),
          ),
          (route) => false,
        );
      }
    } on Exception {
      showCustomDialog(
        dialog: "Unauthorized Access!",
        context: context,
      );
    }
  }

  doEmployeeLogin(BuildContext context) async {
    try {
      await AuthServices().doEmployeeLogin();

      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const EmployeeMainNavigationView(),
            ),
            (route) => false);
      }
    } on Exception {
      showCustomDialog(
        dialog: "Unauthorized Access!",
        context: context,
      );
    }
  }
}
