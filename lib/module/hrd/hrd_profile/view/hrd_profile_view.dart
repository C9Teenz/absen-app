import 'package:flutter/material.dart';
import 'package:absensi/core.dart';
import '../controller/hrd_profile_controller.dart';

class HrdProfileView extends StatefulWidget {
  const HrdProfileView({Key? key}) : super(key: key);

  Widget build(context, HrdProfileController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
              onPressed: () => controller.doLogout(),
              icon: const Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: const Column(
            children: [],
          ),
        ),
      ),
    );
  }

  @override
  State<HrdProfileView> createState() => HrdProfileController();
}
