import 'package:flutter/material.dart';
import 'package:absensi/core.dart';
import '../../../../shared/widgets/custom_dropdown.dart';

class HrdEmployeeFormView extends StatefulWidget {
  const HrdEmployeeFormView({Key? key}) : super(key: key);

  Widget build(context, HrdEmployeeFormController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("HrdEmployeeForm"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextFormField(
                onChanged: (value) {
                  controller.fullName = value;
                },
                decoration: const InputDecoration(
                    hintText: "Full Name",
                    border:
                        OutlineInputBorder(borderSide: BorderSide(width: 1))),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                onChanged: (value) {
                  controller.email = value;
                },
                decoration: const InputDecoration(
                    hintText: "Email",
                    border:
                        OutlineInputBorder(borderSide: BorderSide(width: 1))),
              ),
              const SizedBox(
                height: 20.0,
              ),
              QDropdownField(
                label: "Roles",
                items: const [
                  {
                    "label": "Staff",
                    "value": "Staff",
                  },
                  {
                    "label": "Supervaisor",
                    "value": "Supervaisor",
                  },
                  {
                    "label": "Manager",
                    "value": "Manager",
                  },
                ],
                value: controller.position,
                onChanged: (value, label) {
                  controller.position = value;
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: CustomButton(
            text: "Save",
            onPressed: () {
              controller.doSave();
            },
            width: MediaQuery.of(context).size.width,
            icon: Icons.save,
            color: const Color(0xff00060b)),
      ),
    );
  }

  @override
  State<HrdEmployeeFormView> createState() => HrdEmployeeFormController();
}
