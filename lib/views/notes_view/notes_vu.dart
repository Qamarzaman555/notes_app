import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes/utils/utils.dart';
import 'package:notes/widgets/uk_appbar.dart';
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
      appBar: UkAppBar(
        title: 'Notes',
        actions: [
          IconButton(
              onPressed: () {
                viewModel.logOut(context);
              },
              icon: const Icon(Icons.logout_outlined)),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        child: StreamBuilder<QuerySnapshot>(
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
            return ListView.separated(
              itemCount: viewModel.notes.length,
              itemBuilder: (context, index) {
                final note = viewModel.notes[index];
                return ListTile(
                  tileColor:
                      Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                AddNotesVU(uuid: uuid, notes: note)));
                  },
                  title: Text(note.message ?? '',
                      style: Theme.of(context).textTheme.headlineSmall),
                  subtitle: Text(
                    viewModel.getTimeDate(note.timestamp ?? ''),
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      viewModel.deleteNote(
                          userId: uuid,
                          noteId: viewModel.notes[index].uuid.toString());
                    },
                    icon: Icon(
                      Icons.delete_outline,
                      color: Colors.red.shade400,
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return 12.spaceY;
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddNotesVU(uuid: uuid);
          }));
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
        ),
      ),
    );
  }

  @override
  NotesVM viewModelBuilder(BuildContext context) => NotesVM();
}
