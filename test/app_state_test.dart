import 'package:flutter_test/flutter_test.dart';
import 'package:micro_todo/models/models.dart';
import 'package:micro_todo/screens/add_todo_screen.dart';

void main() {
  test('Empty Text Field Test', () {
    var result = FieldValidator.validateField('');
    expect(result, 'Enter valid content!');
  });

  test('To check all todo items completed', () {
    final todos = [
      TodoItemModel('Init item added', isDone: true),
      TodoItemModel('sec item enabled'),
      TodoItemModel('to check unit test'),
    ];
    final position = ItemStatus(
      todos: todos,
    );

    position.toCompleteAll();
    expect(position.todos.every((t) => t.isDone), isTrue);

    position.toCompleteAll();
    expect(position.todos.every((t) => !t.isDone), isTrue);
  });

  test('To find if any already completed todo items', () {
    final state = ItemStatus(todos: [
      TodoItemModel('Init item added'),
      TodoItemModel('sec item enabled', isDone: true),
      TodoItemModel('to check final test'),
    ]);

    expect(state.toDosDone, true);
  });
}
