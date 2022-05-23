import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:navokinotes/blocs/home_bloc.dart';
import 'package:navokinotes/callbacks/click_callback.dart';
import 'package:navokinotes/model/note_model.dart';
import 'package:navokinotes/utils/device.dart';
import 'package:navokinotes/widgets/item_widget.dart';
import 'package:provider/provider.dart';

/// Note List UI
class NoteList extends StatefulWidget {
  final ClickCallback? onSelect;

  const NoteList({this.onSelect, super.key});

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  late HomeBloc homeBloc;
  late int diff;
  late Device device;
  late Timer timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    device = Device(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);

    homeBloc = Provider.of<HomeBloc>(context);
    diff = device.deviceWidth.round() - device.deviceHeight.round();

    return getStaggeredView();
  }

  /// Note List in Staggered View
  Widget getStaggeredView() {
    return LayoutBuilder(builder: (context, snapshot) {
      return MasonryGridView.count(
        crossAxisCount: getCrossAxisCount(),
        //  crossAxisCount: 3,
        //  mainAxisSpacing: 2,
        //     crossAxisSpacing: 2,
        /*     staggeredTileBuilder: (int index) {
          int vertical = 2;
          if (homeBloc.notesList[index].description != null &&
              '\n'.allMatches(homeBloc.notesList[index].description).length >
                  5) {
            vertical = 3;
          }
          return StaggeredTile.count(2, vertical);
        },*/
        itemCount: homeBloc.notesList.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              selectCard(homeBloc.notesList[index], index);
            },
            child: ItemWidget(homeBloc.notesList[index], device),
          );
        },
      );
    });
  }

  /// Note List in List View
  Widget getListView() {
    return SizedBox(
      height: device.deviceHeight,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => selectCard(homeBloc.notesList[index], index),
            key: ObjectKey(homeBloc.notesList[index]),
            child: ItemWidget(homeBloc.notesList[index], device),
          );
        },
        itemCount: homeBloc.notesList.length,
      ),
    );
  }

  /// Opens a new note or existing note if [noteModel] isNotEmpty
  void selectCard(NoteModel noteModel, int index) {
    homeBloc.notesBloc;
    noteModel.itemIndex = index;
    homeBloc.notesBloc.note = noteModel;
    widget.onSelect!(null, null, true);
  }

  /// CrossAxisCount depends on screen size
  int getCrossAxisCount() {
    if (diff < -100) {
      return 2;
    } else if (diff > -100 && diff <= 600) {
      return 4;
    } else if (diff < 1000) {
      return 6;
    }
    return 2;
  }
}
