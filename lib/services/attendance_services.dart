import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AttendanceServices {
  checkIn({
    required String deviceModel,
    required String deviceid,
    required double latitude,
    required double longitude,
    required String time,
  }) async {
    await FirebaseFirestore.instance.collection("attendances").add({
      "device_model": deviceModel,
      "device_id": deviceid,
      "latitude": latitude,
      "longitude": longitude,
      "time": time,
      "date": Timestamp.now(),
      "user": {
        "uid": FirebaseAuth.instance.currentUser!.uid,
        "email": FirebaseAuth.instance.currentUser!.email,
        "name": FirebaseAuth.instance.currentUser!.displayName,
      }
    });
  }
}
