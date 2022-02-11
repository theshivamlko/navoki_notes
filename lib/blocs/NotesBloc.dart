import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keepapp/model/NoteModel.dart';
import 'package:keepapp/utils/Api.dart' as Api;
import 'package:keepapp/utils/Utils.dart';

class NotesBloc {
  NoteModel? note;
  // NoteModel selectedNote;
  String? token;

  NotesBloc.empty() {
    note = NoteModel();
    note!.colorValue = Colors.red.value;
  }


  void addNote(BuildContext context)async {
    note!.title=note!.title??'';
    note!.description=note!.description??'';
    
   await Api.addNote(note!).then((value) {
    }).catchError((error) {
      Utils.showToast(Utils.getErrorMessage(error));
    });
  }

  void update(BuildContext context)async {
    note!.title=note!.title??'';
    note!.description=note!.description??'';

    await Api.updateData(note!).then((value) {
      }).catchError((error) {
        Utils.showToast(Utils.getErrorMessage(error));
      });

  }

  void delete(BuildContext context) async{
     await Api.deleteNote(note!).then((value) {
      }).catchError((error) {
        Utils.showToast(Utils.getErrorMessage(error));
      });

  }
}
