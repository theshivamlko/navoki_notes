import 'package:flutter/material.dart';
import 'package:navokinotes/model/note_model.dart';
import 'package:navokinotes/utils/device.dart';

/// Note Card UI in List
class ItemWidget extends StatefulWidget {
  final NoteModel noteModel;
  final Device device;

  const ItemWidget(this.noteModel, this.device, {super.key});

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  Image? background;
  late int diff;
  late Device device;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    device = Device(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    diff = device.deviceWidth.round() - device.deviceHeight.round();

    return Container(
      height: 200,
      padding: const EdgeInsets.all(2),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(
                'assets/images/ic_${widget.noteModel.colorValue}.png',
                height: 150,
                width: 150,
                fit: BoxFit.fill,
              )),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.noteModel.title ?? '',
                    maxLines: 1,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'OpenSans'),
                  ),
                ),
                Container(
                  color: Colors.white30,
                  height: 1,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.noteModel.description ?? '',
                      maxLines: getMaxLines(),
                      style: const TextStyle(
                          fontSize: 14,
                          height: 1,
                          color: Colors.white,
                          fontFamily: 'OpenSans'),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// CrossAxisCount depends on screen size
  int getMaxLines() {
    if (diff <= 600) {
      return 5;
    } else if (diff < 1000) {
      return 6;
    }
    return 2;
  }
}
