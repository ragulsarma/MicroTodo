import 'package:flutter/material.dart';
import 'package:micro_todo/models/models.dart';
import 'package:micro_todo/themes/strings.dart';
import 'package:micro_todo/screens/todo_detail_screen.dart';
import 'package:micro_todo/widgets/single_item_todo_widget.dart';
import 'package:micro_todo/utils/typedefs.dart';

//--- Widget to render each list item in dashboard screen
class TodoList extends StatelessWidget {
  final bool isLoading;
  final ToInsertItem toAddItem;
  final ToDeleteItem toRemoveItem;
  final ToUpdateItem toUpdateItem;
  final List<TodoItemModel> allList;

  const TodoList({
    Key? key,
    required this.isLoading,
    required this.toAddItem,
    required this.toRemoveItem,
    required this.toUpdateItem,
    required this.allList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator())
          : ListView.builder(
              key: const Key(allToDoList),
              physics: const BouncingScrollPhysics(),
              itemCount: allList.length,
              itemBuilder: (BuildContext context, int index) {
                //--- assign item with current position
                final todo = allList[index];

                return SingleItemTodo(
                  todoItem: todo,
                  onRemoved: (direction) {
                    _deleteItem(context, todo);
                  },
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) {
                          return ToDoDetailScreen(
                            todo: todo,
                            onDelete: () => _deleteItem(context, todo),
                            toInsertItem: toAddItem,
                            updateItem: toUpdateItem,
                          );
                        },
                      ),
                    );
                  },
                  onCheckBoxStateChange: (complete) {
                    toUpdateItem(todo, isDone: !todo.isDone);
                  },
                );
              },
            ),
    );
  }

  //--- to delete an item from list and local storage
  void _deleteItem(BuildContext context, TodoItemModel todo) {
    toRemoveItem(todo);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        key: const Key('SnackBar'),
        duration: const Duration(seconds: 2),
        content: Text(
          'Item deleted : ${todo.desc}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            toAddItem(todo);
          },
        ),
      ),
    );
  }
}
