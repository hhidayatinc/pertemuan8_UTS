import 'package:flutter/material.dart';
import 'package:simple_note/models/konten.dart';

class AddNote extends StatefulWidget{
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
        title : konten == null ? Text('Add Note') : Text('Edit Note'),
        leading : new IconButton(
          icon: new Icon(Icons.arrow_back), 
          onPressed: (){Navigator.pop(context);
          },
          )
      ),
    );
  }
}