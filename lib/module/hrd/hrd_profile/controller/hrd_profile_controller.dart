import 'package:flutter/material.dart';
import 'package:absensi/core.dart';

class HrdProfileController extends State<HrdProfileView> {
  static late HrdProfileController instance;
  late HrdProfileView view;

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
    Get.offAll(const LoginView());
  }
}
