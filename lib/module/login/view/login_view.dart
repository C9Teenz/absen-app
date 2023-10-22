import 'package:flutter/material.dart';
import 'package:absensi/core.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  Widget build(context, LoginController controller) {
    controller.view = this;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://images.unsplash.com/photo-1543872084-c7bd3822856f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1887&q=80",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
            ),
          ),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    "https://icons.iconarchive.com/icons/thesquid.ink/free-flat-sample/256/owl-icon.png",
                    width: 120.0,
                    height: 120.0,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    "Absensi Online",
                    style: GoogleFonts.lobster(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  CustomButton(
                      text: "Login as HRD",
                      onPressed: () async {
                        controller.doHRDLogin(context);
                      },
                      width: MediaQuery.of(context).size.width,
                      icon: Icons.supervised_user_circle_sharp,
                      color: const Color(0xff00060b)),
                  const SizedBox(
                    height: 20.0,
                  ),
                  CustomButton(
                      text: "Login as Employee",
                      onPressed: () => controller.doEmployeeLogin(context),
                      width: MediaQuery.of(context).size.width,
                      icon: Icons.supervised_user_circle_outlined,
                      color: const Color(0xff017aff)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  State<LoginView> createState() => LoginController();
}
