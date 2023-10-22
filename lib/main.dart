
import 'package:absensi/module/login/view/login_view.dart';
import 'package:absensi/state_util.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
   Get.navigatorKey;
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
   
    return MaterialApp(
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xff0e0c23),
                iconTheme: IconThemeData(color: Colors.white),
                titleTextStyle: TextStyle(color: Colors.white)),
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0xff017aff)),
            useMaterial3: true,
            textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                selectedItemColor: Color(0xff027aff),
                unselectedItemColor: Color(0xffcccccc))),
        home: const LoginView());
  }
}
