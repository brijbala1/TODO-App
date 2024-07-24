class NoteModel {
  int? id;
  String? name;
  String? bloadGroup;
  int? age;

  NoteModel({this.bloadGroup, this.age, this.name});

  NoteModel.withId({this.id, this.age, this.name, this.bloadGroup});

  int? get _id => id;

  String? get _name => name;

  String? get _bloadGroup => bloadGroup;

  int? get _age => age;

  set title(String title) {
    name = title;
  }

  set group(String group) {
    bloadGroup = group;
  }

  set ageLimit(int limit) {
    age = limit;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    if (map['id'] != null) {
      map['id'] = id;
    }
    map['name'] = name;
    map['age'] = age;
    map['bloodgroup'] = bloadGroup;
    return map;
  }

  NoteModel.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.age = map['age'];
    this.bloadGroup = map['bloodgroup'];
  }
}
