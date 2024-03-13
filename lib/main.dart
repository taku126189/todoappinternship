import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app_internship/screens/todo_screen.dart';

void main() {
  runApp(ProviderScope(
    child: MaterialApp(
      title: 'TodoApp',
      darkTheme: ThemeData.dark(useMaterial3: false),
      themeMode: ThemeMode.dark,
      home: const TodoScreen(),
    ),
  ));
}
