import 'dart:convert';
import 'package:micro_todo/key_value_store_flutter.dart';
import 'package:micro_todo/repo/repository.dart';
import 'package:micro_todo/models/todo_model.dart';

class ValuesStorage implements MicroTodoRepo {
  final String key;
  final KeyValueStore keyValueStore;
  final JsonCodec jsonCodec;

  const ValuesStorage({required this.key, required this.keyValueStore, this.jsonCodec = json});

  //---load items using abstract class method into list items
  @override
  Future<List<TodoModel>> loadItems() async {
    return jsonCodec
        .decode(keyValueStore.getStringValue(key)!)['todos'].cast<Map<String, Object>>()
        .map<TodoModel>(TodoModel.fromJson)
        .toList(growable: false);
  }

  //--- encode json and save items as a list
  @override
  Future<bool> saveItems(List<TodoModel> todosItem) {
    return keyValueStore.setStringValue(key,
      jsonCodec.encode({
        'todos': todosItem.map((todo) => todo.toJson()).toList(),
      }),
    );
  }
}
