import 'package:micro_todo/models/models.dart';

//---typedef setup for microtodo app---
typedef ToUpdateItem = void Function(
  TodoItemModel todoItemModel, {
  String id,
  String title,
  String desc,
  bool isDone,
});

typedef ToDeleteItem = void Function(TodoItemModel todoItemModel);

typedef ToInsertItem = void Function(TodoItemModel todoItemModel);
