import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:absensi/core.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EmployeeAttendenceView extends StatefulWidget {
  const EmployeeAttendenceView({Key? key}) : super(key: key);

  Widget build(context, EmployeeAttendenceController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("EmployeeAttendence"),
        actions: const [],
      ),
      body: Stack(
        children: [
          if (controller.position != null) ...[
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Builder(
                builder: (context) {
                  List<Marker> allMarkers = [
                    Marker(
                      point: LatLng(
                        controller.position!.latitude,
                        controller.position!.longitude,
                      ),
                      child: const Icon(
                        Icons.pin_drop,
                        color: Colors.red,
                        size: 24,
                      ),
                    ),
                  ];
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: FlutterMap(
                      options: MapOptions(
                        initialCenter: LatLng(
                          controller.position!.latitude,
                          controller.position!.longitude,
                        ),
                        initialZoom: 16,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName:
                              'dev.fleaflet.flutter_map.example',
                        ),
                        MarkerLayer(
                          markers: allMarkers,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Positioned(
                left: 20,
                right: 20,
                bottom: 20,
                child: Card(
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.deviceModel!,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(),
                        Row(
                          children: [
                            SizedBox(
                              height: 120.0,
                              width: 120.0,
                              child: CustomImagePicker(
                                label: "",
                                onChanged: (p0) {
                                  controller.photoUrl = p0;
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 12.0,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AuthServices().currentUser!.displayName!,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    controller.dateString,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    controller.time,
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: AttendanceServices().attendanceSnapshot(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) return const Text("Error");
                            if (snapshot.data == null) return Container();

                            final data = snapshot.data!;
                            bool isCheckInToday = data.docs.isEmpty;
                            return Container(
                              child: Column(
                                children: [
                                  CustomButton(
                                      text: "Check in",
                                      onPressed: isCheckInToday
                                          ? () {
                                              if (controller.photoUrl == null) {
                                                showCustomDialog(
                                                  dialog: "Photo is required",
                                                );
                                              } else {
                                                controller.doCheckIn();
                                              }
                                            }
                                          : () {},
                                      width: MediaQuery.of(context).size.width,
                                      icon: MdiIcons.doorOpen,
                                      color: isCheckInToday
                                          ? const Color(0xff027aff)
                                          : Colors.grey[300]!),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  CustomButton(
                                      text: "Check out",
                                      onPressed: isCheckInToday
                                          ? () {}
                                          : () {
                                              if (controller.photoUrl == null) {
                                                showCustomDialog(
                                                  dialog: "Photo is required",
                                                );
                                              } else {
                                                controller.doCheckOut();
                                              }
                                            },
                                      width: MediaQuery.of(context).size.width,
                                      icon: MdiIcons.doorClosed,
                                      color: isCheckInToday
                                          ? Colors.grey[300]!
                                          : Colors.red)
                                ],
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ))
          ],
          if (controller.position == null)
            const Center(
                child: Card(
              child: Text("Get Location...."),
            ))
        ],
      ),
    );
  }

  @override
  State<EmployeeAttendenceView> createState() => EmployeeAttendenceController();
}
