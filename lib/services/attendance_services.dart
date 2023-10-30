import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class AttendanceServices {
  checkIn(
      {required String deviceModel,
      required String deviceid,
      required double latitude,
      required double longitude,
      required String time,
      required String photoUrl}) async {
    await FirebaseFirestore.instance.collection("attendances").add({
      "checkin_info": {
        "device_model": deviceModel,
        "device_id": deviceid,
        "latitude": latitude,
        "longitude": longitude,
        "time": time,
        "date": Timestamp.now(),
        "attendance_date": DateFormat("d-MMM-y").format(DateTime.now()),
        "photo_url": photoUrl,
      },
      "user": {
        "uid": FirebaseAuth.instance.currentUser!.uid,
        "email": FirebaseAuth.instance.currentUser!.email,
        "name": FirebaseAuth.instance.currentUser!.displayName,
      }
    });
  }

  checkOut(
      {required String deviceModel,
      required String deviceid,
      required double latitude,
      required double longitude,
      required String time,
      required String photoUrl}) async {
    var data = await FirebaseFirestore.instance
        .collection("attendances")
        .where("user.uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("checkin_info.attendance_date",
            isEqualTo: DateFormat("d-MMM-y").format(DateTime.now()))
        .get();
    if (data.docs.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection("attendances")
          .doc(data.docs.first.id)
          .update({
        "checkout_info": {
          "device_model": deviceModel,
          "device_id": deviceid,
          "latitude": latitude,
          "longitude": longitude,
          "time": time,
          "date": Timestamp.now(),
          "attendance_date": DateFormat("d-MMM-y").format(DateTime.now()),
          "photo_url": photoUrl,
        },
      });
    }
  }

  Stream<QuerySnapshot<Object?>>? attendanceSnapshot() {
    return FirebaseFirestore.instance
        .collection("attendances")
        .where("user.uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("checkin_info.attendance_date",
            isEqualTo: DateFormat("d-MMM-y").format(DateTime.now()))
        .snapshots();
  }

  Stream<QuerySnapshot<Object?>>? attendanceHistorySnapshot({required DateTime date}) {
    return FirebaseFirestore.instance
        .collection("attendances")
        .where("user.uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("checkin_info.attendance_date",
            isEqualTo: DateFormat("d-MMM-y").format(date))
        .snapshots();
  }

  Future<bool> calculateDistance(
      {required double currentLat, required double currentLng}) async {
    // Membuat objek Location
    var companySnapshot = await FirebaseFirestore.instance
        .collection("company_profile")
        .doc("main-company")
        .get();
    Map<String, dynamic> locationSnapshot =
        companySnapshot.data() as Map<String, dynamic>;
    // Menghitung jarak antara dua lokasi
    double distanceInMeters = GeolocatorPlatform.instance.distanceBetween(
        currentLat,
        currentLng,
        locationSnapshot["latitude"],
        locationSnapshot["longitude"]);
    print(distanceInMeters);
    return distanceInMeters > 100;
  }
}
