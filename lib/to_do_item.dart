import 'package:uuid/uuid.dart';

class ToDoItem {
  final String id;
  final String title;

  ToDoItem(this.id, this.title);

  factory ToDoItem.empty() => ToDoItem(Uuid().v4(), "");

  ToDoItem copyWith(String title) => ToDoItem(this.id, title);

  bool isEmpty() => title == "";

  @override
  bool operator ==(Object other) => identical(this, other) || other is ToDoItem && runtimeType == other.runtimeType && title == other.title;

  @override
  int get hashCode => title.hashCode;
}
