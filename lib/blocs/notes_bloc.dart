import 'package:flutter/material.dart';
import 'package:navokinotes/model/note_model.dart';
import 'package:navokinotes/utils/api.dart' as api;
import 'package:navokinotes/utils/utils.dart';

class NotesBloc {
  NoteModel? note;
  // NoteModel selectedNote;
  String? token;

  NotesBloc.empty() {
    note = NoteModel();
    note!.colorValue = Colors.red.value;
  }

  void addNote(BuildContext context) async {
    note!.title = note!.title ?? '';
    note!.description = note!.description ?? '';

    await api.addNote(note!).then((value) {}).catchError((error) {
      Utils.showToast(Utils.getErrorMessage(error));
    });
  }

  void update(BuildContext context) async {
    note!.title = note!.title ?? '';
    note!.description = note!.description ?? '';

    await api.updateData(note!).then((value) {}).catchError((error) {
      Utils.showToast(Utils.getErrorMessage(error));
    });
  }

  void delete(BuildContext context) async {
    await api.deleteNote(note!).then((value) {}).catchError((error) {
      Utils.showToast(Utils.getErrorMessage(error));
    });
  }
}
