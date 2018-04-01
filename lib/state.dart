import 'package:todo_demo_flutter_redux/to_do_item.dart';

class AppState {
  final List<ToDoItem> toDos;

  AppState(this.toDos);

  factory AppState.empty() => AppState(List.unmodifiable([]));
}
