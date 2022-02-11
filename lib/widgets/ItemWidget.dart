import 'package:flutter/material.dart';
import 'package:keepapp/model/NoteModel.dart';
import 'package:keepapp/utils/Device.dart';

/// Note Card UI in List
class ItemWidget extends StatefulWidget {
  NoteModel noteModel;
  Device device;

  ItemWidget(this.noteModel, this.device);

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
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
    device = Device(MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    diff = device.deviceWidth.round() - device.deviceHeight.round();

    return Container(
      height: 200,
      padding: EdgeInsets.all(2),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
              child: Image.asset(
            'assets/images/ic_${widget.noteModel.colorValue}.png',
            height: 150,
            width: 150,
            fit: BoxFit.fitHeight,
          )),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    widget.noteModel.title ?? '',
                    maxLines: 1,
                    style: TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'OpenSans'),
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
                      style: TextStyle(fontSize: 14, height: 1, color: Colors.white, fontFamily: 'OpenSans'),
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
      return 5;
    } else if (diff < 1000) {
      return 6;
    }
    return 2;
  }
}
