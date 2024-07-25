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
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      size: 40,
                      color: Colors.white,
                    ),
                    Text(
                      "NO RECORD FOUND",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: count,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddDetailScreen(
                                noteList: noteList![index]))).then((val) {
                      Future<List<NoteModel>> noteListFuture =
                          dbHelper.getNoteList();
                      noteListFuture.then((noteList) {
                        setState(() {
                          this.noteList = noteList;
                          this.count = noteList.length;
                        });
                      });
                    });
                  },
                  child: getCard(
                      noteList![index].name.toString(),
                      noteList![index].age,
                      noteList![index].bloadGroup,
                      noteList![index]),
                ),
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
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
          color: Colors.orange.shade900,
        ),
      ),
    );
  }

  getCard(String title, subtitle, trailing, NoteModel noteModel) {
    return Card(
      margin: EdgeInsets.only(left: 10, right: 10),
      color: Colors.white24,
      shadowColor: Colors.white24,
      child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Color(0xffFF1883),
            child: Text(
              title[0].toUpperCase(),
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          title: Text(
            title.toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          subtitle: Text(
            "Age: ".toUpperCase() +
                subtitle.toString().toUpperCase() +
                " years",
            style: TextStyle(color: Colors.white),
          ),
          trailing: InkWell(
            onTap: () {
              dbHelper.deleteNote(noteModel).then((onValue) {
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
              Icons.delete,
              color: Colors.white,
            ),
          )),
    );
  }
}
