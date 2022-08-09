import 'package:micro_todo/models/todo_model.dart';

class ItemStatus {
  bool isLoading;
  List<TodoItemModel> todos;

  ItemStatus({
    this.isLoading = false,
    this.todos = const [],
  });

  factory ItemStatus.loading() => ItemStatus(isLoading: true);

  List<TodoItemModel> allItems() => todos.toList();

  bool get isAllItemsDone => todos.every((todo) => todo.isDone);

  void toCompleteAll() {
    final allDone = isAllItemsDone;
    for (var todo in todos) {
      todo.isDone = !allDone;
    }
  }

  bool get toDosDone {
    return todos.any((todo) => todo.isDone);
  }
}

class TodoItemModel {
  String id;
  String title;
  String desc;
  bool isDone;

  TodoItemModel(this.title,
      {this.isDone = false, this.desc = '', this.id = ''});

  TodoModel toTheModel() {
    return TodoModel(title: title, id: id, desc: desc, isDone: isDone);
  }

  static TodoItemModel fromTodoItemModel(TodoModel entity) {
    return TodoItemModel(entity.title,
        isDone: entity.isDone, desc: entity.desc, id: entity.id);
  }
}
