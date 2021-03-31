class Note {
  int _id;
  int _idKategori;
  String title;
  String note;
  String date;
  
  int get id => this._id;
  set id(int value) => this._id = value;

  int get idKategori => this._idKategori;
  set idKategori(int value) => this._idKategori = value;

  String get getTitle => this.title;
  set setTitle(String title) => this.title = title;

  String get getNote => this.note;
  set setNote(String note) => this.note = note;

  String get getDate => this.date;
  set setDate(String date) => this.date = date;

}
