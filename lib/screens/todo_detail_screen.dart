import 'package:flutter/material.dart';
import 'package:micro_todo/screens/add_todo_screen.dart';
import 'package:micro_todo/models/models.dart';
import 'package:micro_todo/themes/strings.dart';
import 'package:micro_todo/themes/themes.dart';
import 'package:micro_todo/utils/typedefs.dart';

//---Item detail view screen widget----
class ToDoDetailScreen extends StatelessWidget {
  final TodoItemModel todo;
  final Function onDelete;
  final ToInsertItem toInsertItem;
  final ToUpdateItem updateItem;

  const ToDoDetailScreen({
    Key? key,
    required this.todo,
    required this.toInsertItem,
    required this.updateItem,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text(toDoDetails),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              onDelete();
              Navigator.pop(context, todo);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Checkbox(
                    value: todo.isDone,
                    onChanged: (complete) {
                      updateItem(todo, isDone: !todo.isDone);
                    },
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                          bottom: 10.0,
                        ),
                        child: Text(
                          todo.title,
                          style: regularWhiteText,
                        ),
                      ),
                      Text(
                        todo.desc,
                        style: smallWhiteText,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: () {
          //navigation to edit/add item screen
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return AddTodoScreen(
                  updateItem: updateItem,
                  addItem: toInsertItem,
                  todo: todo,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
