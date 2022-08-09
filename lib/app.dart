import 'package:flutter/material.dart';
import 'package:micro_todo/save_load_storage_item.dart';
import 'package:micro_todo/key_value_store_flutter.dart';
import 'package:micro_todo/repo/repository.dart';
import 'package:micro_todo/routes.dart';
import 'package:micro_todo/screens/add_todo_screen.dart';
import 'package:micro_todo/screens/dashboard_screen.dart';
import 'package:micro_todo/models/models.dart';
import 'package:micro_todo/themes/strings.dart';
import 'package:micro_todo/themes/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MicroApp extends StatefulWidget {
  const MicroApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MicroAppState();
  }
}

class MicroAppState extends State<MicroApp> {
  late MicroTodoRepo microTodoRepo;
  ItemStatus itemStatus = ItemStatus.loading();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getLocalData();
    });
  }

  //get stored items from local storage
  _getLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    microTodoRepo = StorageLocalRepo(
      localTodoRepo: ValuesStorage(
        key: 'micro_todo',
        keyValueStore: StoreKeyValue(prefs),
      ),
    );

    microTodoRepo.loadItems().then((loadedList) {
      setState(() => itemStatus = ItemStatus(
            todos: loadedList.map(TodoItemModel.fromTodoItemModel).toList(),
          ));
    });
  }

  //--- to rebuild the UI when data change
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);

    microTodoRepo.saveItems(
      itemStatus.todos.map((todo) => todo.toTheModel()).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => appTitle,
      theme: currentTheme,
      routes: {
        MicroToDoRoutes.dashboard: (context) {
          return DashboardScreen(
            itemStatus: itemStatus,
            updateTodo: updateItems,
            addTodo: (todo) => setState(() => itemStatus.todos.add(todo)),
            removeTodo: (todo) => setState(() => itemStatus.todos.remove(todo)),
          );
        },
        MicroToDoRoutes.addTodo: (context) {
          return AddTodoScreen(
            addItem: (todo) => setState(() => itemStatus.todos.add(todo)),
            updateItem: updateItems,
          );
        },
      },
    );
  }

  //--- to update each items on user data change
  void updateItems(
    TodoItemModel todo, {
    String? id,
    String? title,
    String? desc,
    bool? isDone,
  }) {
    setState(() {
      todo.isDone = isDone ?? todo.isDone;
      todo.id = id ?? todo.id;
      todo.desc = desc ?? todo.desc;
      todo.title = title ?? todo.title;
    });
  }
}
