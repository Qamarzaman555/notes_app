import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../add_notes_view/add_notes_vu.dart';
import 'notes_vm.dart';

class NotesVU extends StackedView<NotesVM> {
  final String uuid;
  const NotesVU({super.key, required this.uuid});

  @override
  void onViewModelReady(NotesVM viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.listenToNotes(uuid);
  }

  @override
  Widget builder(BuildContext context, NotesVM viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(title: Text('Notes $uuid')),
      body: StreamBuilder<QuerySnapshot>(
        stream: viewModel.notesStream(uuid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            debugPrint('StreamBuilder: Waiting for data...');
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            debugPrint('StreamBuilder: Error - ${snapshot.error}');
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            debugPrint('StreamBuilder: No notes found');
            return const Center(child: Text('No notes found'));
          }

          debugPrint('StreamBuilder: Data received');
          return ListView.builder(
            itemCount: viewModel.notes.length,
            itemBuilder: (context, index) {
              final note = viewModel.notes[index];
              return ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => AddNotesVU(uuid: uuid, notes: note)));
                },
                title: Text(note.message ?? ''),
                subtitle: Text(viewModel.getTimeDate(note.timestamp ?? '')),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddNotesVU(uuid: uuid);
          }));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  NotesVM viewModelBuilder(BuildContext context) => NotesVM();
}
