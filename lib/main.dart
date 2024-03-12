import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app_internship/todo_screen.dart';

void main() {
  runApp(ProviderScope(
    child: MaterialApp(
      title: 'TodoApp',
      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 7, 40, 228),
        ),
      ),
      home: const TodoScreen(),
    ),
  ));
}
