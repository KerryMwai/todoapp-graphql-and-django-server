
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/core/controller/todo_controller.dart';
import 'package:todo_app/core/data/model/add_todo_model.dart';
import 'package:todo_app/core/data/model/todo_model.dart';
import 'package:todo_app/core/presentation/widget/custom_text_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController=TextEditingController();
  TodoController controller=Get.put(TodoController());

  @override
  void initState() {
   controller.allTodosFromdatabase();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    TodoController controller = Get.put(TodoController());
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Obx(() => GridView.builder(
          itemCount: controller.allTodosFromdatabase.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2 / 3),
          itemBuilder: (context, index) {
            final todo=controller.allTodosFromdatabase[index];
            return Card(
              margin: const EdgeInsets.all(5),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      todo.title,
                      maxLines: 3,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.3),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                         Text(
                          "Completed: ",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.2,
                              decoration: todo.completed?TextDecoration.lineThrough:TextDecoration.none
                              ),
                        ),
                       const SizedBox(
                          width: 5,
                        ),
                        Checkbox(
                          
                          value: todo.completed,
                          onChanged: (value) => controller.updateTodo(Todo(todo.id, todo.title, todo.completed?false:true)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    IconButton(onPressed: ()async{
                      await controller.deleteTodo(todo.id);
                    }, icon: const Icon(Icons.delete, size: 33, color: Colors.red,))
                  ],
                ),
              ),
            );
          })),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showTodoDialog();
        },
        tooltip: 'Get todols',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }




  Future<void> showTodoDialog() async {
    TodoController controller =Get.find();
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Todo'),
        content:  SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              CustomTextField(textEditingController: titleController)
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Add'),
            onPressed: () async{
              await controller.addTodo(TodoToBeAdded(titleController.text)).then((value) =>  Navigator.of(context).pop()).then((value) => titleController.clear());
             
            },
          ),
        ],
      );
    },
  );
}
}
