/// Note info
class NoteModel {
  String? title;
  String? description;
  String? itemId;
  int? colorValue;
  String? createTime;
  int? itemIndex;

  NoteModel();

  NoteModel.store(this.itemId, this.title, this.description, this.colorValue);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['title'] = title;
    map['description'] = description;
    map['colorValue'] = colorValue.toString();

    return map;
  }
}
