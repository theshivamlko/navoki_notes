
/// Note info
class NoteModel {
  String title;
  String description;
  String itemId;
  int colorValue;
  String createTime;
  int itemIndex;

  NoteModel();
  NoteModel.store(this.itemId,this.title, this.description,   this.colorValue);


}
