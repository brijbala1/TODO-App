import 'package:flutter/material.dart';
import 'package:todo_app/Screen/add_detail_screen.dart';
import '../common-widgets/database-helper.dart';
import '../common-widgets/widgets.dart';
import '../model/note_model.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dbHelper = DatabaseHelper();
  List<NoteModel>? noteList;
  int count = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future<List<NoteModel>> noteListFuture = dbHelper.getNoteList();
    noteListFuture.then((noteList) {
      setState(() {
        this.noteList = noteList;
        this.count = noteList.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFF1883),
        title: Text(
          "TODO LIST",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: CustonContainer(
          child: count == 0
              ? Text(
                  "No Data Add ",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )
              : ListView.builder(
                  itemCount: count,
                  itemBuilder: (context, index) => getCard(
                        noteList![index].name.toString(),
                        noteList![index].age,
                        noteList![index].bloadGroup,
                      ))),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffFF6B38),
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddDetailScreen()))
              .then((val) {
            Future<List<NoteModel>> noteListFuture = dbHelper.getNoteList();
            noteListFuture.then((noteList) {
              setState(() {
                this.noteList = noteList;
                this.count = noteList.length;
              });
            });
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  getCard(String title, subtitle, trailing) {
    return Card(
      color: Colors.deepOrange.shade100,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Color(0xffFF1883),
          child: Text(
            title[0].toUpperCase(),
            style: TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          "name: ".toUpperCase() + title.toUpperCase(),
        ),
        subtitle: Text(
            "Age: ".toUpperCase() + subtitle.toString().toUpperCase()),
        trailing: Text(trailing.toString().toUpperCase()),
      ),
    );
  }
}
