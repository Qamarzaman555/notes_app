import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../models/note_model.dart';

class NotesVM extends BaseViewModel {
  List<NotesModel> notes = [];

  Stream<QuerySnapshot> notesStream(String uuid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uuid)
        .collection('notes')
        .snapshots();
  }

  void listenToNotes(String uuid) {
    notesStream(uuid).listen((data) {
      notes.clear();
      for (final doc in data.docs) {
        final obj = doc.data() as Map<String, dynamic>;
        obj['uuid'] = doc.id; // Ensure the correct ID is used
        notes.add(NotesModel.fromJson(obj));
      }
      notifyListeners();
    }, onError: (error) {
      debugPrint('Error listening to notes stream: $error');
    });
  }

  String getTimeDate(String timestamp) {
    final DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));
    final DateFormat formatter = DateFormat('h:mm a EEE');
    return formatter.format(dateTime);
  }
}
