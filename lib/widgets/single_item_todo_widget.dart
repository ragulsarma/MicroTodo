import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:micro_todo/models/models.dart';
import 'package:micro_todo/themes/strings.dart';
import 'package:micro_todo/themes/themes.dart';

//--- widget to show single todo item on listview (with slide to delete option)
class SingleItemTodo extends StatelessWidget {
  final GestureTapCallback onTap;
  final TodoItemModel todoItem;
  final SlidableActionCallback onRemoved;
  final ValueChanged<bool?> onCheckBoxStateChange;

  const SingleItemTodo({
    Key? key,
    required this.onTap,
    required this.todoItem,
    required this.onRemoved,
    required this.onCheckBoxStateChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(todoItem.id),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () {}),
        children: [
          //widget to show on slide of each item
          SlidableAction(
            onPressed: onRemoved,
            icon: Icons.delete,
            label: delete,
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFFD42725),
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: onRemoved,
            icon: Icons.delete,
            label: delete,
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFFD42725),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        leading: Checkbox(
          key: Key(todoItem.id),
          value: todoItem.isDone,
          onChanged: onCheckBoxStateChange,
        ),
        title: Text(
          todoItem.title,
          key: Key(todoItem.id),
          style: regularWhiteText,
        ),
        subtitle: Text(
          todoItem.desc,
          maxLines: 1,
          key: Key(todoItem.id),
          overflow: TextOverflow.ellipsis,
          style: smallWhiteText,
        ),
      ),
    );
  }
}
