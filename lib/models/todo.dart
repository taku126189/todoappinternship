import 'package:intl/intl.dart';

class Todo {
  const Todo({
    required this.title,
    required this.date,
    required this.id,
    this.completed = false,
  });

  final String id;
  final String title;
  final DateTime date;
  final bool completed;

  String get formattedDate {
    final dateformat = DateFormat.yMd().format(date);
    final timeformat = DateFormat.jm().format(date);
    return '$dateformat | $timeformat';
  }
}
