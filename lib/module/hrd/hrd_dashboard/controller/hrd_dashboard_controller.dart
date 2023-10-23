import 'package:flutter/material.dart';
import 'package:absensi/core.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
      "label": "Company Profile",
      "icon": MdiIcons.officeBuilding,
      "page": const HrdCompanyProfileView()
    },
    {
      "label": "Employee",
      "icon": Icons.people,
      "page": const HrdEmployeeListView()
    },
  ];
}
