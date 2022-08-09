import 'dart:core';

import 'package:micro_todo/models/todo_model.dart';
import 'pre_loaded_items.dart';

//---Repo abstract class to save/load items
abstract class MicroTodoRepo {
  Future<List<TodoModel>> loadItems();

  Future saveItems(List<TodoModel> todos);
}

class StorageLocalRepo implements MicroTodoRepo {
  final MicroTodoRepo localTodoRepo;
  final MicroTodoRepo preLoadedTodoRepo;

  const StorageLocalRepo({
    required this.localTodoRepo,
    this.preLoadedTodoRepo = const PreLoadedItems(),
  });

  @override
  Future saveItems(List<TodoModel> todos) {
    return Future.wait<dynamic>([
      localTodoRepo.saveItems(todos),
      preLoadedTodoRepo.saveItems(todos),
    ]);
  }

  @override
  Future<List<TodoModel>> loadItems() async {
    try {
      return await localTodoRepo.loadItems();
    } catch (e) {
      final todos = await preLoadedTodoRepo.loadItems();

      await localTodoRepo.saveItems(todos);

      return todos;
    }
  }
}
