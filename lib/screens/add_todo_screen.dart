import 'dart:async';

import 'package:flutter/material.dart';
import 'package:micro_todo/models/models.dart';
import 'package:micro_todo/themes/strings.dart';
import 'package:micro_todo/themes/themes.dart';
import 'package:micro_todo/utils/typedefs.dart';

//--- Widget to render add/edit item screen
class AddTodoScreen extends StatefulWidget {
  final TodoItemModel? todo;
  final ToInsertItem addItem;
  final ToUpdateItem updateItem;

  const AddTodoScreen({
    Key? key,
    required this.addItem,
    required this.updateItem,
    this.todo,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  String? _tempNote;
  String? _tempTask;

  //to enable edit/add icon according to current state
  bool get isModifying => widget.todo != null;

  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(isModifying ? editTodo : addTodo),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          onWillPop: () => Future(() => true),
          autovalidateMode: AutovalidateMode.disabled,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              TextFormField(
                  style: regularWhiteText,
                  textCapitalization: TextCapitalization.sentences,
                  onSaved: (value) => _tempTask = value,
                  autofocus: isModifying ? false : true,
                  initialValue: widget.todo != null ? widget.todo!.title : '',
                  decoration: const InputDecoration(
                    hintText: mainHint,
                    hintStyle: TextStyle(fontSize: 22),
                  ),
                  validator: (val) => FieldValidator.validateField(
                      val ?? '') //(val ?? '').trim().isEmpty ? '' : null,
                  ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                maxLines: 10,
                style: regularWhiteText,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                onSaved: (value) => _tempNote = value,
                initialValue: widget.todo != null ? widget.todo!.desc : '',
                decoration: const InputDecoration(
                  hintText: extraNotes,
                  hintStyle: TextStyle(fontSize: 17),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(isModifying ? Icons.check : Icons.add),
          onPressed: () {
            final form = formKey.currentState;
            if (form!.validate()) {
              form.save();

              final setTask = _tempTask;
              final setNote = _tempNote;

              if (isModifying) {
                widget.updateItem(widget.todo!,
                    title: setTask ?? '', desc: setNote ?? '');
              } else {
                widget.addItem(TodoItemModel(
                  setTask ?? '',
                  desc: setNote ?? '',
                ));
              }

              Navigator.pop(context);
            }
          }),
    );
  }
}

class FieldValidator {
  static String? validateField(String value) {
    if (value.isEmpty) {
      return 'Enter valid content!';
    }

    return null;
  }
}
