import 'package:flutter/material.dart';
import 'package:absensi/core.dart';

class HrdDashboardView extends StatefulWidget {
  const HrdDashboardView({Key? key}) : super(key: key);

  Widget build(context, HrdDashboardController controller) {
    controller.view = this;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                          Icon(
                            item['icon'],
                            size: 32.0,
                            color: const Color(0xff087af9),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            item['label'],
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
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
  State<HrdDashboardView> createState() => HrdDashboardController();
}
