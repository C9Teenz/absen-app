import 'package:flutter/material.dart';
import 'package:absensi/core.dart';

class HrdDashboardController extends State<HrdDashboardView> {
  static late HrdDashboardController instance;
  late HrdDashboardView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  List dashboardMenuItems = [
    {"label": "Explorer", "icon": Icons.explore, "page": Container()},
    {"label": "Appointment", "icon": Icons.date_range, "page": Container()},
    {"label": "Shop", "icon": Icons.shopping_bag, "page": Container()},
    {
      "label": "Employee",
      "icon": Icons.people,
      "page": const HrdEmployeeListView()
    },
  ];
}
