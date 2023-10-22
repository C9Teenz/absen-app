import 'package:flutter/material.dart';
import 'package:absensi/core.dart';
import '../view/hrd_main_navigation_view.dart';

class HrdMainNavigationController extends State<HrdMainNavigationView> {
  static late HrdMainNavigationController instance;
  late HrdMainNavigationView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  int selectedIndex = 0;
  updateIndex(int newIndex) {
    selectedIndex = newIndex;
    setState(() {});
  }
}
