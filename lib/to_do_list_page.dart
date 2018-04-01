import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:todo_demo_flutter_redux/state.dart';
import 'package:todo_demo_flutter_redux/actions.dart';
import 'package:todo_demo_flutter_redux/to_do_item.dart';

class ToDoListPage extends StatelessWidget {
  ToDoListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.create(store),
        builder: (BuildContext context, _ViewModel viewModel) => Scaffold(
              appBar: AppBar(
                title: Text(title),
              ),
              body: ListView(children: viewModel.items.map((_ItemViewModel item) => _createWidget(item)).toList()),
              floatingActionButton: FloatingActionButton(
                onPressed: viewModel.onNewItem,
                tooltip: viewModel.newItemToolTip,
                child: Icon(Icons.add),
              ),
            ),
      );

  Widget _createWidget(_ItemViewModel item) {
    if (item is _EmptyItemViewModel) {
      return _createEmptyItemWidget(item);
    } else {
      return _createToDoItemWidget(item);
    }
  }

  Widget _createEmptyItemWidget(_EmptyItemViewModel item) => Column(
        children: [
          TextField(
            onSubmitted: item.onUpdateItemTitle,
            autofocus: true,
            decoration: new InputDecoration(
              hintText: item.updateItemToolTip,
            ),
          )
        ],
      );

  Widget _createToDoItemWidget(_ToDoItemViewModel item) => Row(
        children: [
          Text(item.title),
          FlatButton(
            onPressed: item.onDeleteItem,
            child: Icon(
              Icons.delete,
              semanticLabel: item.deleteItemToolTip,
            ),
          )
        ],
      );
}

class _ViewModel {
  final List<_ItemViewModel> items;
  final Function onNewItem;
  final String newItemToolTip;

  _ViewModel(this.items, this.onNewItem, this.newItemToolTip);

  factory _ViewModel.create(Store<AppState> store) {
    List<_ItemViewModel> items = store.state.toDos
        .map((ToDoItem item) => _ToDoItemViewModel(item.title, () {
              store.dispatch(RemoveItemAction(item));
              store.dispatch(SaveListAction());
            }, 'Delete') as _ItemViewModel)
        .toList();

    if (store.state.listState == ListState.listWithNewItem) {
      items.add(_EmptyItemViewModel('Type the next task here', (String title) {
        store.dispatch(DisplayListOnlyAction());
        store.dispatch(AddItemAction(ToDoItem(title)));
        store.dispatch(SaveListAction());
      }, 'Add'));
    }

    return _ViewModel(items, () => store.dispatch(DisplayListWithNewItemAction()), 'Add new to-do item');
  }
}

abstract class _ItemViewModel {}

@immutable
class _EmptyItemViewModel extends _ItemViewModel {
  final String hint;
  final Function onUpdateItemTitle;
  final String updateItemToolTip;

  _EmptyItemViewModel(this.hint, this.onUpdateItemTitle, this.updateItemToolTip);
}

@immutable
class _ToDoItemViewModel extends _ItemViewModel {
  final String title;
  final Function onDeleteItem;
  final String deleteItemToolTip;

  _ToDoItemViewModel(this.title, this.onDeleteItem, this.deleteItemToolTip);
}
