import 'package:flutter_test/flutter_test.dart';
import 'package:todo_demo_flutter_redux/actions.dart';
import 'package:todo_demo_flutter_redux/reducers.dart';
import 'package:todo_demo_flutter_redux/state.dart';
import 'package:todo_demo_flutter_redux/to_do_item.dart';

void main() {
  test('add an item', () {
    AppState state = AppState(List.unmodifiable([]), ListState.listWithNewItem);
    ToDoItem item = ToDoItem("title");

    AppState result = appReducer(state, AddItemAction(item));

    expect(result.toDos, containsAllInOrder([item]));
  });

  test('remove an item', () {
    ToDoItem item1 = ToDoItem("title1");
    ToDoItem item2 = ToDoItem("title2");
    AppState state = AppState(List.unmodifiable([item1, item2]), ListState.listWithNewItem);

    AppState result = appReducer(state, RemoveItemAction(item1));

    expect(result.toDos, containsAllInOrder([item2]));
  });

  test('display list only', () {
    AppState state = AppState(List.unmodifiable([]), ListState.listWithNewItem);

    AppState result = appReducer(state, DisplayListOnlyAction());

    expect(result.listState, equals(ListState.listOnly));
  });

  test('display list with new item', () {
    AppState state = AppState(List.unmodifiable([]), ListState.listOnly);

    AppState result = appReducer(state, DisplayListWithNewItemAction());

    expect(result.listState, equals(ListState.listWithNewItem));
  });
}
