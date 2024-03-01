class Task {
  String? id;
  String? title;
  String? desc;
  DateTime? date;
  bool? isdone;

  Task(
      {this.id,
      required this.title,
      required this.desc,
      this.date,
      this.isdone = false});

  Task.fromJson(Map<String, dynamic> json)
      : this(
            title: json['title'],
            date: DateTime.fromMillisecondsSinceEpoch(json['date']??0),
            desc: json['desc'],
            id: json['id'],
            isdone: json['isdone']);

  Map<String, dynamic> toJson(Task task) {
    return {
      'id': task.id,
      'title': task.title,
      'desc': task.desc,
      'date':task.date?.millisecondsSinceEpoch,
      'isdone': task.isdone,
    };
  }

  /* this.id=json['id'];
   this.title=json['title'];
   this.desc=json['desc'];
   this.date=json['datetime'];
   this.isdone=json['isdone'];*/
}
