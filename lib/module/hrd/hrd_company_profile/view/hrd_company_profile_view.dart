import 'package:absensi/services/company_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:absensi/core.dart';

class HrdCompanyProfileView extends StatefulWidget {
  const HrdCompanyProfileView({Key? key}) : super(key: key);

  Widget build(context, HrdCompanyProfileController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("HrdCompanyProfile"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: CompanyService().companySnapshot(),
            builder: (context, snapshot) {
              if (snapshot.hasError) return const Text("Error");
              if (snapshot.data == null) return Container();

              if (snapshot.data!.docs.isNotEmpty) {
                controller.currentData =
                    snapshot.data!.docs.first.data() as Map<String, dynamic>;
              }
              return Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue:
                          controller.currentData?["company_name"] ?? "",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please fill company name";
                        }
                        return null;
                      },
                      decoration:
                          const InputDecoration(label: Text("Company Name")),
                      onChanged: (value) {
                        controller.companyName = value;
                      },
                    ),
                    TextFormField(
                      initialValue: controller.currentData?["address"] ?? "",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please fill company address";
                        }
                        return null;
                      },
                      maxLines: 3,
                      decoration:
                          const InputDecoration(label: Text("Company Address")),
                      onChanged: (value) {
                        controller.address = value;
                      },
                    ),
                    QLocationPicker(
                      id: "location",
                      label: "Location",
                      latitude: controller.currentData?["latitude"] ?? 0.0,
                      longitude: controller.currentData?["longitude"] ?? 0.0,
                      onChanged: (latitude, longitude) {
                        controller.latitude = latitude;
                        controller.longitude = longitude;
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        child: CustomButton(
            text: "Save",
            onPressed: () {
              bool isValidated = controller.formKey.currentState!.validate();
              if (!isValidated) {
                showCustomDialog(
                    dialog: "Please Fill required field");
              } else {
                controller.doSave();
                Navigator.pop(context);
              }
            },
            width: double.infinity,
            icon: Icons.save,
            color: const Color(0xff027aff)),
      ),
    );
  }

  @override
  State<HrdCompanyProfileView> createState() => HrdCompanyProfileController();
}
