import 'package:flutter/cupertino.dart';
 import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:keepapp/blocs/HomeBloc.dart';
import 'package:keepapp/callbacks/ClickCallback.dart';
import 'package:keepapp/enums/NoteActions.dart';
 import 'package:keepapp/utils/Device.dart';
import 'package:provider/provider.dart';

/// Note Card details UI
class NoteDetail extends StatefulWidget {
  int? index;
  ClickCallback onCancel;

  NoteDetail({  this.index, required this.onCancel});

  @override
  _NoteDetailState createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  late  HomeBloc homeBloc;
  late Device device;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      if (homeBloc.notesBloc.note != null) {
        descriptionController.text = homeBloc.notesBloc.note!.description??"";
        titleController.text = homeBloc.notesBloc.note!.title??"";
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    device = Device(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);

    homeBloc = Provider.of<HomeBloc>(context);

    return WillPopScope(
      onWillPop: () async {
        manageNote();
        return false;
      },
      child: Container(
        height: device.deviceHeight,
        width: device.deviceWidth ,
      color: Color(homeBloc.notesBloc.note!.colorValue!),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                AppBar(
                  backgroundColor: Color(homeBloc.notesBloc.note!.colorValue!),
                  elevation: 0,
                  actions: [
                    homeBloc.notesBloc.note!.itemId != null
                        ? IconButton(
                            onPressed: () {
                              homeBloc.notesBloc.delete(context);
                              widget.onCancel(null, NoteActions.DELETE, false);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 30,
                            ),
                          )
                        : Container(),
                    IconButton(
                      onPressed: () => colorPicker(),
                      icon: Icon(
                        Icons.color_lens,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    device.isMobile
                        ? IconButton(
                            onPressed: () {
                              manageNote();
                            },
                            icon: Icon(
                              Icons.clear,
                              size: 30,
                              color: Colors.white,
                            ),
                          )
                        : Container(),
                  ],
                ),
                SingleChildScrollView(
                  child: Container(
                    width: device.deviceWidth,
                    child: Column(
                      children: [
                        TextFormField(
                          cursorColor: Colors.white30,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Title",
                              hintStyle: TextStyle(
                                fontSize: 25,
                                color: Colors.white60,
                                fontWeight: FontWeight.bold,
                              ),
                              contentPadding: EdgeInsets.all(8.0)),
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          controller: titleController,
                          maxLines: 1,
                        ),
                        Container(
                          color: Colors.white30,
                          height: 1,
                        ),
                        Container(
                          child: TextFormField(
                            style: TextStyle(fontSize: 20, color: Colors.white),
                            showCursor: true,
                            cursorColor: Colors.white30,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter note",
                              hintStyle: TextStyle(
                                  fontSize: 16, color: Colors.white60),
                              contentPadding:
                                  EdgeInsets.only(left: 8.0, right: 8.0),
                            ),
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            controller: descriptionController,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );

  }

  /// Change selected color from color picker box
  void changeColor(Color color) => setState(() {
        homeBloc.notesBloc.note!.colorValue = color.value;
      });

  /// Opens color picker box
  void colorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select a color'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: Color(homeBloc.notesBloc.note!.colorValue!),
              onColorChanged: changeColor,
            ),
          ),
        );
      },
    );
  }

  /// add or update or delete a note
  void manageNote() {
    homeBloc.notesBloc.note!.title = titleController.text;
    homeBloc.notesBloc.note!.description = descriptionController.text;
    if ((homeBloc.notesBloc.note!.title != null &&
            homeBloc.notesBloc.note!.title!.trim().isNotEmpty) ||
        (homeBloc.notesBloc.note!.description != null &&
            homeBloc.notesBloc.note!.description!.trim().isNotEmpty)) {
      if (homeBloc.notesBloc.note!.itemId == null) {
        homeBloc.notesBloc.addNote(context);
        widget.onCancel(null, NoteActions.ADD, true);
      } else {
        homeBloc.notesBloc.update(context);
        widget.onCancel(null, NoteActions.UPDATE, false);
      }
    }
    widget.onCancel(null, null, false);
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
