import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:absensi/shared/widgets/horizontal_datepicker/horizontal_datepicker.dart';
import 'package:flutter/material.dart';
import 'package:absensi/core.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EmployeeAttendenceHistoryView extends StatefulWidget {
  const EmployeeAttendenceHistoryView({Key? key}) : super(key: key);

  Widget build(context, EmployeeAttendenceHistoryController controller) {
    controller.view = this;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      AuthServices().currentUser!.displayName!,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey.withOpacity(0.5),
                    child: const CircleAvatar(
                      radius: 19,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 6.0,
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey.withOpacity(0.5),
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 19,
                      child: Badge(
                        label: Text(
                          "4",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        child: Icon(
                          Icons.notifications_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              HorizontalDatePicker(
                onChanged: (date) {
                  controller.updateData(date: date);
                },
              ),
              const SizedBox(
                height: 8.0,
              ),
              const Divider(),
              const SizedBox(
                height: 8.0,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: controller.datas,
                builder: (context, snapshot) {
                  if (snapshot.hasError) return const Text("Error");
                  if (snapshot.data == null) return Container();
                  if (snapshot.data!.docs.isEmpty) {
                    return const Text("No Data");
                  }
                  final data = snapshot.data!;
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: ListView.builder(
                      itemCount: data.docs.length,
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.zero,
                      clipBehavior: Clip.none,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> item =
                            (data.docs[index].data() as Map<String, dynamic>);
                        item["id"] = data.docs[index].id;
                        //convert timestamp to date
                        var checkInDate =
                            (item["checkin_info"]["date"] as Timestamp)
                                .toDate();

                        String dateNow =
                            DateFormat("dd MMMM").format(checkInDate);
                        bool isCheckout = item["checkout_info"] != null;
                        var checkInInfo = item["checkin_info"];
                        var checkOutInfo = item["checkout_info"];
                        var userName = item["user"]["name"];
                        bool ddMMMM = dateNow ==
                            DateFormat("dd MMMM").format(DateTime.now());
                        bool isCheckoutToday = false;
                        String dateNowOut = "";
                        if (item["checkout_info"] != null) {
                          var checkOutDate =
                              (item["checkout_info"]["date"] as Timestamp)
                                  .toDate();
                          dateNowOut =
                              DateFormat("dd MMMM").format(checkOutDate);
                          isCheckoutToday = dateNowOut ==
                              DateFormat("dd MMMM").format(DateTime.now());
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 12.0,
                            ),
                            Text(
                              dateNow,
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.grey[500]),
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            Card(
                              child: Container(
                                height: 140,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: const Color(0xff017aff)),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      bottom: 0,
                                      child: ClipPath(
                                        clipper:
                                            ArrowClipper(40, 140, Edge.RIGHT),
                                        child: Container(
                                          padding: const EdgeInsets.all(12.0),
                                          height: 60,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.45,
                                          color: Colors.white.withOpacity(0.3),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const Text(
                                                    "Check-in Time",
                                                    style: TextStyle(
                                                        fontSize: 12.0,
                                                        color: Colors.white),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(
                                                    width: 6.0,
                                                  ),
                                                  Icon(
                                                    MdiIcons.checkDecagram,
                                                    size: 16.0,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 16.0,
                                              ),
                                              Text(
                                                checkInInfo["time"],
                                                style: const TextStyle(
                                                    fontSize: 40.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                ddMMMM ? "Today" : dateNow,
                                                style: const TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        right: 0,
                                        top: 0,
                                        bottom: 0,
                                        child: Container(
                                          padding: const EdgeInsets.all(12.0),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.43,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.phone_android,
                                                    size: 24.0,
                                                    color: Colors.white,
                                                  ),
                                                  const SizedBox(
                                                    width: 4.0,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      checkInInfo[
                                                          "device_model"],
                                                      style: const TextStyle(
                                                          fontSize: 16.0,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  const Icon(
                                                      Icons.developer_board,
                                                      size: 20.0,
                                                      color: Colors.white),
                                                ],
                                              ),
                                              const Spacer(),
                                              Text(
                                                userName,
                                                style: const TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.white),
                                              ),
                                              const SizedBox(
                                                height: 4.0,
                                              ),
                                              const Text(
                                                "Last seen - Just now",
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                            if (isCheckout)
                              Card(
                                child: Container(
                                  height: 140,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: const Color(0xff0e0c22)),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: 0,
                                        left: 0,
                                        bottom: 0,
                                        child: ClipPath(
                                          clipper:
                                              ArrowClipper(40, 140, Edge.RIGHT),
                                          child: Container(
                                            padding: const EdgeInsets.all(12.0),
                                            height: 60,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.45,
                                            color:
                                                Colors.white.withOpacity(0.3),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Check-Out Time",
                                                      style: TextStyle(
                                                          fontSize: 12.0,
                                                          color: Colors.white),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    const SizedBox(
                                                      width: 6.0,
                                                    ),
                                                    Icon(
                                                      MdiIcons.checkDecagram,
                                                      size: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 16.0,
                                                ),
                                                Text(
                                                  checkOutInfo["time"],
                                                  style: const TextStyle(
                                                      fontSize: 40.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  isCheckoutToday
                                                      ? "Today"
                                                      : dateNowOut,
                                                  style: const TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          right: 0,
                                          top: 0,
                                          bottom: 0,
                                          child: Container(
                                            padding: const EdgeInsets.all(12.0),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.43,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.phone_android,
                                                      size: 24.0,
                                                      color: Colors.white,
                                                    ),
                                                    const SizedBox(
                                                      width: 4.0,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        checkOutInfo[
                                                            "device_model"],
                                                        style: const TextStyle(
                                                            fontSize: 16.0,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    const Icon(
                                                        Icons.developer_board,
                                                        size: 20.0,
                                                        color: Colors.white),
                                                  ],
                                                ),
                                                const Spacer(),
                                                Text(
                                                  userName,
                                                  style: const TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.white),
                                                ),
                                                const SizedBox(
                                                  height: 4.0,
                                                ),
                                                const Text(
                                                  "Last seen - Just now",
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  State<EmployeeAttendenceHistoryView> createState() =>
      EmployeeAttendenceHistoryController();
}
