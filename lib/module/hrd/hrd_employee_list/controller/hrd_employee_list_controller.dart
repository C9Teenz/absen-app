
import 'package:flutter/material.dart';
import 'package:absensi/core.dart';
import '../view/hrd_employee_list_view.dart';

class HrdEmployeeListController extends State<HrdEmployeeListView> {
    static late HrdEmployeeListController instance;
    late HrdEmployeeListView view;

    @override
    void initState() {
        instance = this;
        super.initState();
    }

    @override
    void dispose() => super.dispose();

    @override
    Widget build(BuildContext context) => widget.build(context, this);
}
        
    