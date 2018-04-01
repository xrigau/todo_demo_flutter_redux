import 'package:todo_demo_flutter_redux/to_do_item.dart';

class CreateEmptyItemAction {}

class RemoveItemAction {
  final ToDoItem item;

  RemoveItemAction(this.item);
}

class UpdateItemTitleAction {
  final ToDoItem item;
  final String title;

  UpdateItemTitleAction(this.item, this.title);
}

class SaveListAction {}
