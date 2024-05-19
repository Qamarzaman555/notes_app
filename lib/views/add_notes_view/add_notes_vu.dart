import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../models/note_model.dart';
import '../../widgets/uk_appbar.dart';
import '../../widgets/uk_text_field.dart';
import 'add_notes_vm.dart';

class AddNotesVU extends StackedView<AddNotesVM> {
  final NotesModel? notes;
  final String uuid; // Add a UUID parameter
  const AddNotesVU({super.key, this.notes, required this.uuid});

  @override
  Widget builder(BuildContext context, AddNotesVM viewModel, Widget? child) {
    return Scaffold(
      appBar: UkAppBar(
          title: notes == null ? 'Add Note' : 'Update Note'), // Corrected title
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: viewModel.formKey,
          child: Column(
            children: [
              UkTextField(
                hintText: 'Enter your note',
                initialValue: notes?.message,
                onSaved: viewModel.onNoteSaved,
                validator: viewModel.noteValidator,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(left: 32, right: 32, bottom: 40),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              maximumSize: Size(MediaQuery.sizeOf(context).width / 1.5, 48),
              minimumSize: Size(MediaQuery.sizeOf(context).width / 1.5, 48),
              fixedSize: Size(MediaQuery.sizeOf(context).width / 1.5, 48),
              backgroundColor: Theme.of(context).colorScheme.tertiary),
          onPressed: notes == null
              ? () => viewModel.addUser(uuid) // Pass UUID to addUser
              : () => viewModel.updateUser(uuid), // Pass UUID to updateUser
          child: Text(
            notes == null ? 'Save' : 'Update',
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color:
                    Theme.of(context).colorScheme.onPrimary.withOpacity(0.5)),
          ),
        ),
      ),
    );
  }

  @override
  AddNotesVM viewModelBuilder(BuildContext context) {
    return AddNotesVM(context, notes);
  }
}
