import 'package:get/get.dart';
import 'package:todo_app/core/data/model/add_todo_model.dart';
import 'package:todo_app/core/data/model/todo_model.dart';
import 'package:todo_app/core/doamin/todo_api.dart';

class TodoController extends GetxController {
  RxList allTodosFromdatabase = [].obs;
  RxList completedTodos=[].obs;
  RxList incompleteTodos=[].obs;

  Future setTodos() async {
    allTodosFromdatabase.value = await TodoApi().fetchAllTodos();
  }

  Future<void> addTodo(TodoToBeAdded todo) async {
    await TodoApi().addTodo(todo);
    allTodosFromdatabase.value = await TodoApi().fetchAllTodos();
  }

  Future<void> updateTodo(Todo todo)async{
    await TodoApi().isCompleted(todo);
    allTodosFromdatabase.value = await TodoApi().fetchAllTodos();
  }

  Future<bool> deleteTodo(id)async{
    await TodoApi().deleteTodo(id);
    allTodosFromdatabase.value = await TodoApi().fetchAllTodos();;
    return true;
  }

  Future<void> setcompletedTodos()async{
      completedTodos.value=await TodoApi().getAllcompleteTodo(true);
  }

  Future<void> setIcompleteTodos()async{
    incompleteTodos.value=await TodoApi().getAllIncompleteTodo(false);
  } 
}
