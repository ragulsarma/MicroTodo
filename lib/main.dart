import 'package:flutter/material.dart';
import 'package:micro_todo/app.dart';

void main() async {
  // This is the glue that binds the framework to the Flutter engine
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MicroApp());
}
