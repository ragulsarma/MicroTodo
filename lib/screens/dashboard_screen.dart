import 'package:flutter/material.dart';
import 'package:micro_todo/models/models.dart';
import 'package:micro_todo/routes.dart';
import 'package:micro_todo/widgets/stats_tab_widget.dart';
import 'package:micro_todo/themes/strings.dart';
import 'package:micro_todo/widgets/todo_list_view_widget.dart';
import 'package:micro_todo/utils/typedefs.dart';

//--- Home/Dashboard screen widgets ----
class DashboardScreen extends StatefulWidget {
  final ItemStatus itemStatus;
  final ToInsertItem addTodo;
  final ToDeleteItem removeTodo;
  final ToUpdateItem updateTodo;

  const DashboardScreen({
    required this.itemStatus,
    required this.addTodo,
    required this.removeTodo,
    required this.updateTodo,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text(title),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.more_horiz_outlined)),
        ],
      ),
      body: activeIndex == 0
          ? TodoList(
              allList: widget.itemStatus.allItems(),
              isLoading: widget.itemStatus.isLoading,
              toRemoveItem: widget.removeTodo,
              toAddItem: widget.addTodo,
              toUpdateItem: widget.updateTodo,
            )
          : const StatsTab(),
      floatingActionButton: activeIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, MicroToDoRoutes.addTodo);
              },
              child: const Icon(Icons.add),
            )
          : Container(),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: activeIndex,
          onTap: (index) {
            setState(() => activeIndex = index);
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: todos),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.show_chart,
                ),
                label: stats)
          ]),
    );
  }
}
