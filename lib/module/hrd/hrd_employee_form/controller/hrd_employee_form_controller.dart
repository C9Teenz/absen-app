import 'package:absensi/services/employee_services.dart';
import 'package:flutter/material.dart';
import 'package:absensi/core.dart';

class HrdEmployeeFormController extends State<HrdEmployeeFormView> {
  static late HrdEmployeeFormController instance;
  late HrdEmployeeFormView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  String? fullName;
  String? email;
  String? position;

  doSave() async {
    try {
      await EmployeeServices()
          .add(fullName: fullName!, email: email!, position: position!);
      if (context.mounted) {
        Navigator.pop(context);
      }
    } on Exception {
      showCustomDialog(dialog: "Invalid Email", context: context);
    }
  }
}
