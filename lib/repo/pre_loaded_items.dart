import 'dart:async';

import 'package:micro_todo/repo/repository.dart';
import 'package:micro_todo/models/todo_model.dart';

//--- to enable and show pre loaded items
class PreLoadedItems implements MicroTodoRepo {
  const PreLoadedItems();

  @override
  Future<bool> saveItems(List<TodoModel> todos) async {
    return Future.value(true);
  }

  //---passing default items to model class
  @override
  Future<List<TodoModel>> loadItems() async {
    return Future.delayed(
        const Duration(milliseconds: 2000),
        () => [
              TodoModel(
                id: '1',
                isDone: false,
                title: 'Buy food for da kitty',
                desc: 'With the chickeny bits!',
              ),
              TodoModel(
                id: '2',
                isDone: false,
                title: 'Find a Red Sea dive trip',
                desc: 'Echo vs MY Dream',
              ),
              TodoModel(
                id: '3',
                isDone: true,
                title: 'Book flights to Egypt',
                desc: '',
              ),
              TodoModel(
                id: '4',
                isDone: false,
                title: 'Decide on accommodation',
                desc: '',
              )
            ]);
  }
}
