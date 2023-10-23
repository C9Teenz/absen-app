import 'package:absensi/services/company_service.dart';
import 'package:flutter/material.dart';
import 'package:absensi/core.dart';
import '../view/hrd_company_profile_view.dart';

class HrdCompanyProfileController extends State<HrdCompanyProfileView> {
  static late HrdCompanyProfileController instance;
  late HrdCompanyProfileView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? companyName;
  String? address;
  double? latitude;
  double? longitude;
 Map<String, dynamic>? currentData;

  doSave() async {
    await CompanyService().update(
        companyName: companyName??currentData!["conmpany_name"],
        address: address ??currentData!["address"],
        latitude: latitude??currentData!["latitude"],
        longitude: longitude??currentData!["longitude"]);
  }
}
