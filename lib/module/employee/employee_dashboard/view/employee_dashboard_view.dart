import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:absensi/core.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EmployeeDashboardView extends StatefulWidget {
  const EmployeeDashboardView({Key? key}) : super(key: key);

  Widget build(context, EmployeeDashboardController controller) {
    controller.view = this;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Good Morning",
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            AuthServices().currentUser!.displayName!,
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
                /*
                TODO: Implement this @ controller
                int currentIndex = 0;
                final CarouselController carouselController = CarouselController();
                */
                Builder(builder: (context) {
                  List images = [
                    "https://images.unsplash.com/photo-1497215728101-856f4ea42174?auto=format&fit=crop&q=80&w=1740&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                    "https://plus.unsplash.com/premium_photo-1661281350976-59b9514e5364?auto=format&fit=crop&q=80&w=1738&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                    "https://images.unsplash.com/photo-1542744173-8e7e53415bb0?auto=format&fit=crop&q=80&w=1740&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                  ];

                  return Column(
                    children: [
                      CarouselSlider(
                        carouselController: controller.carouselController,
                        options: CarouselOptions(
                          height: 160.0,
                          autoPlay: true,
                          enlargeCenterPage: false,
                          viewportFraction: 1.0,
                          onPageChanged: (index, reason) {
                            controller.currentIndex = index;
                          },
                        ),
                        items: images.map((imageUrl) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(6.0),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      imageUrl,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: images.asMap().entries.map((entry) {
                          bool isSelected =
                              controller.currentIndex == entry.key;
                          return GestureDetector(
                            onTap: () => controller.carouselController
                                .animateToPage(entry.key),
                            child: Container(
                              width: isSelected ? 40 : 6.0,
                              height: 6.0,
                              margin: const EdgeInsets.only(
                                right: 6.0,
                                top: 12.0,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xff017aff)
                                    : Colors.grey[300],
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(12.0),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  );
                }),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                    padding: const EdgeInsets.all(10),
                    height: 70,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Stark Industries",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "08:00-15:00",
                              style: TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                        StreamBuilder<QuerySnapshot>(
                            stream: AttendanceServices().attendanceSnapshot(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) return const Text("Error");
                              if (snapshot.data == null) return Container();

                              final data = snapshot.data!;
                              bool isCheckInToday = data.docs.isEmpty;

                              if (isCheckInToday) {
                                return CustomButton(
                                    text: "Check In",
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const EmployeeAttendenceView(),
                                          ));
                                    },
                                    width: 180,
                                    icon: MdiIcons.doorOpen,
                                    color: const Color(0xff017aff));
                              }
                              final attendanceToday = data.docs.first.data()
                                  as Map<String, dynamic>;
                              bool isAttendToday =
                                  attendanceToday["checkout_info"] != null;
                              if (isAttendToday) {
                                return CustomButton(
                                    text: "Attend Today",
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const EmployeeAttendenceView(),
                                          ));
                                    },
                                    width: 180,
                                    icon: MdiIcons.checkAll,
                                    color: Colors.green[400]!);
                              }

                              return CustomButton(
                                  text: "Check Out",
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const EmployeeAttendenceView(),
                                        ));
                                  },
                                  width: 180,
                                  icon: MdiIcons.doorOpen,
                                  color: Colors.red);
                            })
                      ],
                    )),
                const SizedBox(
                  height: 20.0,
                ),
                GridView.builder(
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.0,
                    crossAxisCount: 4,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6,
                  ),
                  itemCount: controller.dashboardMenuItems.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    var item = controller.dashboardMenuItems[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => item['page'],
                            ));
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.grey[200],
                            child: Icon(
                              item['icon'],
                              size: 32.0,
                              color: const Color(0xff087af9),
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            item['label'],
                            style: const TextStyle(
                                fontSize: 14.0, color: Color(0xff0e0c23)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<EmployeeDashboardView> createState() => EmployeeDashboardController();
}
