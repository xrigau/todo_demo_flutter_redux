import 'dart:async';
import 'dart:io';

import 'package:todo_demo_flutter_redux/actions.dart';
import 'package:redux/redux.dart';
import 'package:todo_demo_flutter_redux/state.dart';

List<Middleware<AppState>> createStoreMiddleware() =>
    combineTypedMiddleware([
      new MiddlewareBinding<AppState, SaveListAction>(_saveList),
    ]);

Future _saveList(Store<AppState> store, action, NextDispatcher next) async {
  if (action is SaveListAction) {
    await Future.sync(() => Duration(seconds:3)); // TODO: Save to disk
    next(action);
  }
}
