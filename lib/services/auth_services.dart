import 'package:absensi/services/employee_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  Future<void> doHRDLogin() async {
    //snipet fire_login_google
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );

    try {
      await googleSignIn.disconnect();
    } catch (_) {}

    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      var userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user!.email != "langkajenenge89@gmail.com") {
        await FirebaseAuth.instance.signOut();
        throw Exception('Anda bukan HRD');
      }
    } catch (_) {
      throw Exception('Gagal login dengan Google: $_');
    }
  }

  doEmployeeLogin() async {
    //snipet fire_login_google
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );

    try {
      await googleSignIn.disconnect();
    } catch (_) {}

    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      var userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      bool isNotRegistered=await EmployeeServices().isNotRegister(userCredential.user!.email!);
      if(isNotRegistered){
        await FirebaseAuth.instance.signOut();
        throw Exception('Anda belum terdaftar');
      }
    } catch (_) {
      throw Exception(_);
    }
  }

  logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
