import 'package:redux/redux.dart';
import 'package:todo_demo_flutter_redux/state.dart';
import 'package:todo_demo_flutter_redux/to_do_item.dart';
import 'package:todo_demo_flutter_redux/actions.dart';

AppState appReducer(AppState state, action) => AppState(toDoListReducer(state.toDos, action));

final toDoListReducer = combineTypedReducers<List<ToDoItem>>([
  ReducerBinding<List<ToDoItem>, CreateEmptyItemAction>((List<ToDoItem> toDos, dynamic action) => _fixType<CreateEmptyItemAction>(toDos, action, _createEmptyItem)),
  ReducerBinding<List<ToDoItem>, RemoveItemAction>((List<ToDoItem> toDos, dynamic action) => _fixType<RemoveItemAction>(toDos, action, _removeItem)),
  ReducerBinding<List<ToDoItem>, UpdateItemTitleAction>((List<ToDoItem> toDos, dynamic action) => _fixType<UpdateItemTitleAction>(toDos, action, _updateItemTitle)),
]);

List<ToDoItem> _createEmptyItem(List<ToDoItem> toDos, CreateEmptyItemAction action) {
  if (toDos.contains(ToDoItem.empty())) {
    return toDos;
  }

  List<ToDoItem> mutableList = List.from(toDos);
  mutableList.add(ToDoItem.empty());
  return List.unmodifiable(mutableList);
}

List<ToDoItem> _removeItem(List<ToDoItem> toDos, RemoveItemAction action) {
  List<ToDoItem> mutableList = List.from(toDos);
  mutableList.remove(action.item);
  return List.unmodifiable(mutableList);
}

List<ToDoItem> _updateItemTitle(List<ToDoItem> toDos, UpdateItemTitleAction action) {
  List<ToDoItem> mutableList = List.from(toDos);
  mutableList[mutableList.indexOf(action.item)] = action.item.copyWith(action.title);
  return List.unmodifiable(mutableList);
}

List<ToDoItem> _fixType<T>(List<ToDoItem> toDos, T action, Function reducer) => reducer(toDos, action);
