import 'package:flutter/material.dart';
import 'package:todo_app/common-widgets/widgets.dart';
import 'package:todo_app/model/note_model.dart';

import '../common-widgets/database-helper.dart';

class AddDetailScreen extends StatefulWidget {
  AddDetailScreen({super.key, this.noteList});

  NoteModel? noteList;

  @override
  State<AddDetailScreen> createState() => _AddDetailScreenState();
}

class _AddDetailScreenState extends State<AddDetailScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController bloodController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  NoteModel noteModel = NoteModel();
  final dbHelper = DatabaseHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.noteList != null) {
      nameController.text = widget.noteList!.name.toString();
      ageController.text = widget.noteList!.age.toString();
      bloodController.text = widget.noteList!.bloadGroup.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(
          color: Colors.white,
        ),
        title: Text(
          "TODO DETAIL",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xffFF1883),
      ),
      body: CustonContainer(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              enableField("Name", nameController),
              SizedBox(
                height: 20,
              ),
              enableField("Blood-Group", bloodController),
              SizedBox(
                height: 20,
              ),
              enableField("Age", ageController),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                  height: 45,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      noteModel.name = nameController.text.toString();
                      noteModel.age = int.parse(ageController.text.toString());
                      noteModel.bloadGroup = bloodController.text.toString();

                      if (widget.noteList == null) {
                        dbHelper.insert(noteModel, context);
                      } else {
                        noteModel.id = widget.noteList!.id;
                        print("kjkjn");
                        dbHelper.updateNote(noteModel, context);
                      }
                    },
                    child: widget.noteList == null
                        ? Text("Submit")
                        : Text("Update"),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  enableField(String title, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: TextStyle(
              fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 8,
        ),
        TextFormField(
          controller: controller,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white))),
        )
      ],
    );
  }
}
