import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:notes/utils/utils.dart';
import 'package:stacked/stacked.dart';
import '../notes_view/notes_vu.dart';

class SignUpVM extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('User');
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? email, password, name;

  bool obsecurePassword = true;
  bool containsUpperCase = false;
  bool containsLowerCase = false;
  bool containsNumber = false;
  bool containsSpecialChar = false;
  bool contains8Length = false;
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

  String? onChangedValue(val) {
    if (val!.contains(RegExp(r'[A-Z]'))) {
      containsUpperCase = true;
      notifyListeners();
    } else {
      containsUpperCase = false;
      notifyListeners();
    }
    if (val.contains(RegExp(r'[a-z]'))) {
      containsLowerCase = true;
      notifyListeners();
    } else {
      containsLowerCase = false;
      notifyListeners();
    }
    if (val.contains(RegExp(r'[0-9]'))) {
      containsNumber = true;
      notifyListeners();
    } else {
      containsNumber = false;
      notifyListeners();
    }
    if (val.contains(RegExp(r'^(?=.*?[!@#$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^])'))) {
      containsSpecialChar = true;
      notifyListeners();
    } else {
      containsSpecialChar = false;
      notifyListeners();
    }
    if (val.length >= 8) {
      contains8Length = true;
      notifyListeners();
    } else {
      contains8Length = false;
      notifyListeners();
    }
    return null;
  }

  void onEmailSaved(String? value) {
    email = value;
    // user?.email = email;
  }

  void onPasswordSaved(String? value) {
    password = value;
    // user?.email = email;
  }

  void onNameSaved(String? value) {
    password = value;
    // user?.email = email;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }

    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (!RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$')
        .hasMatch(value)) {
      return 'Please enter a valid password';
    }
    return null;
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }

    return null;
  }

  void signUp(BuildContext context) async {
    setBusy(true);
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();

      firebaseAuth
          .createUserWithEmailAndPassword(email: email!, password: password!)
          .then((value) {
        final uid = value.user!.uid.toString();

        firestore.collection('users').doc(uid).set({
          'uid': uid,
          'email': value.user!.email!.toLowerCase(),
          'name': name
        }).then((_) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return NotesVU(uuid: uid);
          }));
        }).catchError((error) {
          Utils.toastMessage(error.toString());
        });

        //   ref.child(value.user!.uid.toString()).set({
        //     'uid': uid,
        //     'email': value.user!.email!.toLowerCase().toString(),
        //   }).then((value) {
        //     // Navigator.pushNamed(context, RouteName.homeScreen);
        //     Navigator.push(context, MaterialPageRoute(builder: (context) {
        //       return NotesVU(uuid: uid);
        //     }));
        //   }).onError((error, stackTrace) {
        //     Utils.toastMessage(error.toString());
        //   });
        //   Utils.toastMessage('User Created Successfully');
        // }).onError((error, stackTrace) {
        //   Utils.toastMessage(error.toString());
      });
    }
    setBusy(false);
  }
}
