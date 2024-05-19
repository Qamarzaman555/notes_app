import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../models/note_model.dart';
import '../../services/fb_client.dart';

class AddNotesVM extends BaseViewModel {
  final _client = FBClient();
  final formKey = GlobalKey<FormState>();
  NotesModel? notes;
  BuildContext context;
  String? message;

  AddNotesVM(this.context, this.notes);

  void onNoteSaved(String? value) {
    message = value;
    notes?.message = message;
  }

  String? noteValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Note cannot be empty';
    }
    return null;
  }

  Future<void> addUser(String uuid) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      notes = NotesModel(
        message: message,
        uuid: uuid,
        timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
      );
      final resp = await _client.post(
          endpoint: 'users/$uuid/notes', data: notes!.toJson());
      if (resp['status'] == 'Ok') {
        Navigator.pop(context);
      } else {
        debugPrint(resp['message']);
      }
    }
  }

  Future<void> updateUser(String uuid) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();

      notes!.timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final resp = await _client.update(
          endpoint: 'users/$uuid/notes/${notes!.uuid}', data: notes!.toJson());
      if (resp['status'] == 'Ok') {
        Navigator.pop(context);
      } else {
        debugPrint(resp['message']);
      }
    }
  }
}
