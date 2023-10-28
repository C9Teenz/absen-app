import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeeServices {
  add({
    required String fullName,
    required String email,
    required String position,
  }) async {
    var snapshot = await FirebaseFirestore.instance
        .collection("employees")
        .where("email", isEqualTo: email)
        .get();
    if (snapshot.docs.isNotEmpty) {
      throw Exception("Email sudah terdaftar");
    }

    await FirebaseFirestore.instance.collection("employees").add({
      "full_name": fullName,
      "email": email,
      "position": position,
    });
  }

  isNotRegister(String email) async {
    var snapshot = await FirebaseFirestore.instance
        .collection("employees")
        .where("email", isEqualTo: email)
        .get();
    if (snapshot.docs.isEmpty) {
      return true;
    }
    return false;
  }

  Stream<QuerySnapshot<Object?>>? employeeSnapshot(){
    return FirebaseFirestore.instance.collection("employees").snapshots();
  }
 
}

//@m.nama =>alt+shift+e