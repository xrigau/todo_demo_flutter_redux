import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:todo_demo_flutter_redux/state.dart';
import 'package:todo_demo_flutter_redux/to_do_list_page.dart';
import 'package:todo_demo_flutter_redux/reducers.dart';
import 'package:todo_demo_flutter_redux/middleware.dart';

void main() => runApp(new ToDoListApp());

class ToDoListApp extends StatelessWidget {
  final Store<AppState> store = new Store<AppState>(
    appReducer,
    initialState: AppState.empty(),
    middleware: createStoreMiddleware(),
  );

  @override
  Widget build(BuildContext context) => StoreProvider(
        store: this.store,
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: ToDoListPage(title: 'Flutter Demo Home Page'),
        ),
      );
}
