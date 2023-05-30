import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/core/controller/todo_controller.dart';
import 'package:todo_app/core/data/model/add_todo_model.dart';
import 'package:todo_app/core/presentation/pages/all_todos.dart';
import 'package:todo_app/core/presentation/widget/custom_text_field.dart';
import 'package:todo_app/core/utils/tab_title.dart';
import 'package:todo_app/feature/home/completed.dart';
import 'package:todo_app/feature/home/not_completed.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController = TextEditingController();
  late TodoController controller;

  @override
  void initState() {
    controller=Get.put(TodoController());
    controller.allTodosFromdatabase();
    controller.setIcompleteTodos();
    controller.setcompletedTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
          bottom: TabBar(
            tabs: List.generate(
              3,
              (index) => Tab(
                text: tabTtitles[index]
              )
            ),
          ),
        ),
        body:const TabBarView(children: [
          AllTodos(),
          CompletedTodos(),
         InCompletedTodos()
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await showTodoDialog();
          },
          tooltip: 'Get todols',
          child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  Future<void> showTodoDialog() async {
    TodoController controller = Get.find();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Todo'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                CustomTextField(textEditingController: titleController)
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Add'),
              onPressed: () async {
                await controller
                    .addTodo(TodoToBeAdded(titleController.text))
                    .then((value) => Navigator.of(context).pop())
                    .then((value) => titleController.clear());
              },
            ),
          ],
        );
      },
    );
  }
}




