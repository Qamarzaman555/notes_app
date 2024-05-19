import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:notes/utils/utils.dart';
import 'package:stacked/stacked.dart';

import '../notes_view/notes_vu.dart';

// import '../../utils/routes/routes_name.dart';
// import '../home_view/home_vu.dart';

class LoginVM extends BaseViewModel {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('User');
  final formKey = GlobalKey<FormState>();
  String? email, password;
  bool obsecurePassword = true;
  IconData iconPassword = Icons.visibility;

  obsecureToggle() {
    obsecurePassword = !obsecurePassword;
    if (obsecurePassword) {
      iconPassword = Icons.visibility;
    } else {
      iconPassword = Icons.visibility_off;
    }
    notifyListeners();
  }

  void onEmailSaved(String? value) {
    email = value;
    // user?.email = email;
  }

  void onPasswordSaved(String? value) {
    password = value;
    // user?.email = email;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    // else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4$}').hasMatch(value)) {
    //   return 'Please enter a valid email';
    // }

    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    //  else if (!RegExp(
    //         r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$')
    //     .hasMatch(value)) {
    //   return 'Please enter a valid password';
    // }
    return null;
  }

  void login(BuildContext context) async {
    setBusy(true);
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();

      try {
        UserCredential userCredential = await firebaseAuth
            .signInWithEmailAndPassword(email: email!, password: password!);
        final uid = userCredential.user!.uid;

        Utils.toastMessage('User Logged In Successfully');

        // Navigate to the Notes view with the user's UID
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return NotesVU(uuid: uid);
        }));
      } catch (error) {
        Utils.toastMessage(error.toString());
      }
    }
    setBusy(false);
  }
}
