import 'dart:async';

import 'package:redux/redux.dart';
import 'package:todo_demo_flutter_redux/actions.dart';
import 'package:todo_demo_flutter_redux/state.dart';

List<Middleware<AppState>> createStoreMiddleware() => [
      TypedMiddleware<AppState, SaveListAction>(_saveList),
    ];

Future _saveList(Store<AppState> store, SaveListAction action, NextDispatcher next) async {
  await Future.sync(() => Duration(seconds: 3)); // Simulate saving the list to disk
  next(action);
}
