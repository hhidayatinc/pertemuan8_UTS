class Konten {
  int _id;
  int _idKategori;
  String _title;
  String _note;
  String _date;
  
  int get id => this._id;
  set id(int value) => this._id = value;

  int get idKategori => this._idKategori;
  set idKategori(int value) => this._idKategori = value;

  String get getTitle => this._title;
  set setTitle(String title) => this._title = title;

  String get getNote => this._note;
  set setNote(String note) => this._note = note;

  String get getDate => this._date;
  set setDate(String date) => this._date = date;

  Konten(this._idKategori,this._date, this._title, this._note);

  Konten.fromMap(Map<String,dynamic>map){
    this._id = map['id'];
    this._idKategori = map['idKategori'];
    this._date = map['date'];
    this._title = map['title'];
    this._note = map['note'];
  }

  Map<String,dynamic> toMap(){
    Map<String,dynamic> map = Map<String,dynamic>();
    map['id'] = this._id;
    map['idKategori'] = this._idKategori;
    map['date'] = this._date;
    map['title'] = this._title;
    map['note'] = this._note;
    return map;
  }
}
