import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_note/models/konten.dart';

class AddNote extends StatefulWidget {
  final Konten konten;
  AddNote(this.konten);
  @override
  AddNoteState createState() => AddNoteState(this.konten);
}

class AddNoteState extends State<AddNote> {
  Konten konten;
  AddNoteState(this.konten);
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  DateTime _chooseDate = DateTime.now();
  List<DropdownMenuItem> _listKategori = [];
  var _valueKategori;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: konten == null ? Text('Add Note') : Text('Edit Note'),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: Padding(
        padding: EdgeInsets.only(top: 15, left: 10, right: 10),
        child: ListView(
          children: <Widget>[
            Image.asset(
              "assets/images/form.png",
              width: MediaQuery.of(context).size.width - 200,
              height: 200,
              fit: BoxFit.fitHeight,
            ),
            SizedBox(
              width: 20.0,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: TextField(
                controller: titleController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Title',
                  hintText: 'Enter Title Here',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: TextField(
                controller: noteController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Note',
                  hintText: 'Note Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              // ignore: deprecated_member_use
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                color: Colors.grey[200],
                child: new Text(new DateFormat(DateFormat.YEAR_MONTH_DAY)
                    .format(_chooseDate)
                    .toString()),
                onPressed: () async {
                  _chooseDate = await showDatePicker(
                          context: context,
                          initialDate: _chooseDate ?? DateTime.now(),
                          lastDate: DateTime(2030),
                          firstDate: DateTime(DateTime.now().year)) ??
                      _chooseDate;
                  setState(() {});
                },
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(),
                  ),
                  child: DropdownButton(
                    hint: Text("Kategori"),
                    items: _listKategori,
                    value: _valueKategori ?? _listKategori.first.value,
                    onChanged: (value) {
                      _valueKategori = value;
                      setState(() {});
                    },
                  ),
                )),
            //SizedBox(height:120.0),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Row(children: <Widget>[
                //tombol simpan
                Expanded(
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,
                    child: Text(
                      'Save',
                      textScaleFactor: 1.2,
                    ),
                    onPressed: () {
                      if (konten == null) {
                        // tambah data
                        konten = Konten(_valueKategori, _chooseDate.toString(),
                            titleController.text, noteController.text);
                      } else {
                        // ubah data
                        konten.idKategori = _valueKategori;
                        konten.setDate = _chooseDate.toString();
                        konten.setTitle = titleController.text;
                        konten.setNote = noteController.text;
                      }
                      // kembali ke layar sebelumnya dengan membawa objek item
                      Navigator.pop(context, konten);
                    },
                  ),
                ),
                Container(
                  width: 5,
                ),
                //tombol batal
                Expanded(
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,
                    child: Text(
                      'Cancel',
                      textScaleFactor: 1.2,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
