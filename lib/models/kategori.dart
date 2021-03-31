class Kategori {
  int _id;
  String _title;

  get id => this._id;
  set id(value) => this._id = value;
  
  String get title => this._title;
  set title(String value) => this._title = value;

  Kategori(this._title);

  Kategori.fromMap(Map<String,dynamic>map){
    this._id = map['id'];
   this._title = map['title'];
  }

  Map<String,dynamic> toMap(){
    Map<String,dynamic> map = Map<String,dynamic>();
    map['id'] = this._id;
    map['title'] = this._title;
    return map;
  }
}
