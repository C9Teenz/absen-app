import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyService{
  update({
    required String companyName,
    required String address,
    required double latitude,
    required double longitude,
  })async{
    await FirebaseFirestore.instance.collection("company_profile").doc('main-company').set({
      "company_name": companyName,
      "address": address,
      "latitude": latitude,
      "longitude": longitude,
    });
  }
}