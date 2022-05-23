import 'package:flutter/cupertino.dart';
import 'package:navokinotes/blocs/notes_bloc.dart';
import 'package:navokinotes/model/note_model.dart';
import 'package:navokinotes/utils/api.dart' as api;
import 'package:navokinotes/utils/local_data_storage.dart';
import 'package:navokinotes/utils/utils.dart';

/// Bloc for [HomePage]
class HomeBloc extends ChangeNotifier {
  List<NoteModel> notesList = List.empty(growable: true);

  NotesBloc notesBloc = NotesBloc.empty();
  // String token;
  String? errorMsg;

  LocalDataStorage localDataStorage = LocalDataStorage();

  /// return notes list to UI
  void getNotes() {
    Utils.showToast('Refreshing...');
    api.getNotes().then((list) {
      if (list.isNotEmpty) {
        notesList = list;
        errorMsg = null;
      } else {
        errorMsg = 'No data found!';
      }
      notifyListeners();
    }).catchError((error) {
      errorMsg = Utils.getErrorMessage(error);
      Utils.showToast(Utils.getErrorMessage(error));
      notifyListeners();
    });
  }

  /// add new note locally to UI
  void appendList() {
    notesList.insert(0, notesBloc.note!);
    notifyListeners();
  }

  /// add new note locally to UI
  void deleteNote() {
    notesList.remove(notesBloc.note);
    notifyListeners();
  }
}
