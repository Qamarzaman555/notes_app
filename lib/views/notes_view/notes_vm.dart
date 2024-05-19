import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../models/note_model.dart';
import '../../services/fb_client.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/utils.dart';

class NotesVM extends BaseViewModel {
  // NotesVM() {
  //   getNotes();
  // }

  List<NotesModel> notes = [];
  List<NotesModel> notesList = [];
  FirebaseAuth auth = FirebaseAuth.instance;

  final _client = FBClient();

  Stream<QuerySnapshot> notesStream(String uuid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uuid)
        .collection('notes')
        .snapshots();
  }

  logOut(BuildContext context) {
    auth.signOut().then((value) {
      Navigator.pushNamed(context, RouteName.welcomeScreen);
      Utils.toastMessage('Logged Out Successfully');
    });
  }

  // Future<void> getNotes() async {
  //   setBusy(true);
  //   final resp = await _client.get(endpoint: 'users');
  //   if (resp["status"] == 'Ok') {
  //     for (final data in resp["data"]) {
  //       final note = NotesModel.fromJson(data);
  //       notes.add(note);
  //       notesList.add(note);
  //     }
  //   } else {
  //     debugPrint(resp['name']);
  //   }
  //   setBusy(false);
  // }

  void listenToNotes(String uuid) {
    notesStream(uuid).listen((data) {
      notes.clear();
      notesList.clear(); // Clear notesList to ensure it contains all notes
      for (final doc in data.docs) {
        final obj = doc.data() as Map<String, dynamic>;
        obj['uuid'] = doc.id; // Ensure the correct ID is used
        final note = NotesModel.fromJson(obj);
        notes.add(note);
        notesList.add(note);
      }
      notifyListeners();
    }, onError: (error) {
      debugPrint('Error listening to notes stream: $error');
    });
  }

  Future<void> deleteNote({
    required String userId,
    required String noteId,
  }) async {
    setBusy(true);
    final response =
        await _client.delete(endpoint: 'users/$userId/notes/$noteId');
    if (response['status'] == 'Ok') {
      // Remove the note from the local lists
      notes.removeWhere((note) => note.uuid == noteId);
      notesList.removeWhere((note) => note.uuid == noteId);
      notifyListeners();
    } else {
      debugPrint('Failed to delete note: ${response['message']}');
    }
    setBusy(false);
  }

  String getTimeDate(String timestamp) {
    final DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));
    final DateFormat formatter = DateFormat('h:mm a EEE');
    return formatter.format(dateTime);
  }
}
