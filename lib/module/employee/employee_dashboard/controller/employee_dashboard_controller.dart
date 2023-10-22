import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:absensi/core.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../view/employee_dashboard_view.dart';

class EmployeeDashboardController extends State<EmployeeDashboardView> {
  static late EmployeeDashboardController instance;
  late EmployeeDashboardView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
  int currentIndex = 0;
  final CarouselController carouselController = CarouselController();

  List dashboardMenuItems = [
    {"label": "Explorer", "icon": Icons.explore, "page": Container()},
    {"label": "Appointment", "icon": Icons.date_range, "page": Container()},
    {"label": "Shop", "icon": MdiIcons.shopping, "page": Container()},
    {"label": "More", "icon": MdiIcons.apps, "page": Container()},
  ];
}
