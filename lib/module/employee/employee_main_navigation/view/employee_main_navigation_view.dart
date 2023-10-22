import 'package:flutter/material.dart';
import '../../../../core.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EmployeeMainNavigationView extends StatefulWidget {
  const EmployeeMainNavigationView({Key? key}) : super(key: key);

  Widget build(context, EmployeeMainNavigationController controller) {
    controller.view = this;

    List<Widget> widgetOptions = <Widget>[
      const EmployeeDashboardView(),
      const EmployeeAttendenceHistoryView(),
      const EmployeeAttendenceView(),
      const EmployeeProfileView()
    ];
    return Scaffold(
      body: widgetOptions.elementAt(controller.selectedIndex),
      bottomNavigationBar: BottomAppBar(
          color: Colors.grey[300],
          clipBehavior: Clip.antiAlias, //agar notch aktif
          shape: const CircularNotchedRectangle(),
          notchMargin: 10, // Atur notchMargin sesuai kebutuhan Anda
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                  child: CustomItemNavBar(
                      title: "Home",
                      icon: Icons.home,
                      index: 0,
                      ontap: () => controller.changeView(0),
                      selectedIndex: controller.selectedIndex)),
              Expanded(
                  child: CustomItemNavBar(
                      title: "History",
                      icon: Icons.history_outlined,
                      index: 1,
                      ontap: () => controller.changeView(1),
                      selectedIndex: controller.selectedIndex)),
              Expanded(
                  child: Container(
                margin: const EdgeInsets.only(top: 23),
                child: Center(
                    child: Text(
                  "Scan",
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                )),
              )),
              Expanded(
                  child: CustomItemNavBar(
                      title: "My Office",
                      icon: Icons.work,
                      index: 2,
                      ontap: () => controller.changeView(2),
                      selectedIndex: controller.selectedIndex)),
              Expanded(
                  child: CustomItemNavBar(
                      title: "Profile",
                      icon: Icons.person,
                      index: 3,
                      ontap: () => controller.changeView(3),
                      selectedIndex: controller.selectedIndex)),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff017aff),
        shape: const CircleBorder(),
        onPressed: () {
          // Tambahkan logika ketika FAB ditekan di sini
        },
        child: Icon(
          MdiIcons.qrcodeScan,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  @override
  State<EmployeeMainNavigationView> createState() =>
      EmployeeMainNavigationController();
}
