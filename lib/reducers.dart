import 'package:redux/redux.dart';
import 'package:todo_demo_flutter_redux/state.dart';
import 'package:todo_demo_flutter_redux/to_do_item.dart';
import 'package:todo_demo_flutter_redux/actions.dart';

AppState appReducer(AppState state, action) => AppState(toDoListReducer(state.toDos, action), listStateReducer(state.listState, action));

final toDoListReducer = combineTypedReducers<List<ToDoItem>>([
  ReducerBinding<List<ToDoItem>, AddItemAction>((List<ToDoItem> toDos, dynamic action) => _fixTypes<List<ToDoItem>, AddItemAction>(toDos, action, _addItem)),
  ReducerBinding<List<ToDoItem>, RemoveItemAction>((List<ToDoItem> toDos, dynamic action) => _fixTypes<List<ToDoItem>, RemoveItemAction>(toDos, action, _removeItem)),
]);

List<ToDoItem> _removeItem(List<ToDoItem> toDos, RemoveItemAction action) {
  List<ToDoItem> mutableList = List.from(toDos);
  mutableList.remove(action.item);
  return List.unmodifiable(mutableList);
}

List<ToDoItem> _addItem(List<ToDoItem> toDos, AddItemAction action) {
  List<ToDoItem> mutableList = List.from(toDos);
  mutableList.add(action.item);
  return List.unmodifiable(mutableList);
}

final listStateReducer = combineTypedReducers<ListState>([
  ReducerBinding<ListState, DisplayListOnlyAction>((ListState listState, dynamic action) => _fixTypes<ListState, DisplayListOnlyAction>(listState, action, _displayListOnly)),
  ReducerBinding<ListState, DisplayListWithNewItemAction>((ListState listState, dynamic action) => _fixTypes<ListState, DisplayListWithNewItemAction>(listState, action, _displayListWithNewItem)),
]);

ListState _displayListOnly(ListState listState, DisplayListOnlyAction action) => ListState.listOnly;

ListState _displayListWithNewItem(ListState listState, DisplayListWithNewItemAction action) => ListState.listWithNewItem;

D _fixTypes<D, A>(D data, A action, Function reducer) => reducer(data, action);
