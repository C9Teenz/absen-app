
import 'package:flutter/material.dart';
import 'package:absensi/core.dart';
import '../view/employee_profile_view.dart';

class EmployeeProfileController extends State<EmployeeProfileView> {
    static late EmployeeProfileController instance;
    late EmployeeProfileView view;

    @override
    void initState() {
        instance = this;
        super.initState();
    }

    @override
    void dispose() => super.dispose();

    @override
    Widget build(BuildContext context) => widget.build(context, this);
     doLogout() async {
    await AuthServices().logout();
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginView(),
          ),
          (route) => false);
    }
  }
}
        
    