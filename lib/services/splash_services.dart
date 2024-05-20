import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/routes/routes_name.dart';
import '../views/notes_view/notes_vu.dart';
import 'session_manager.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      SessionController().userId = user.uid;
      Timer(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NotesVU(uuid: user.uid)),
        );
      });
    } else {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(
            context,
            RouteName
                .welcomeScreen); // Ensure you have this route defined in your route settings.
      });
    }
  }
}
