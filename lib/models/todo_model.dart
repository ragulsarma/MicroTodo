class TodoModel {
  final String id;
  final String title;
  final String desc;
  final bool isDone;

  TodoModel({required this.title, required this.id, required this.desc, required this.isDone});

  Map<String, Object> toJson() {
    return {
      'id': id,
      'title': title,
      'desc': desc,
      'isDone': isDone,
    };
  }
  

  static TodoModel fromJson(Map<String, Object> json) {
    return TodoModel(
      id: json['id'] as String,
      title: json['title'] as String,
      desc: json['desc'] as String,
      isDone: json['isDone'] as bool,
    );
  }
}
