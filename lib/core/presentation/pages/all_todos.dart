import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/core/controller/todo_controller.dart';
import 'package:todo_app/core/data/model/todo_model.dart';

class AllTodos extends StatelessWidget {
  const AllTodos({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodoController>(
      builder: (controller) => GridView.builder(
          itemCount: controller.allTodosFromdatabase.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2 / 3),
          itemBuilder: (context, index) {
            final todo = controller.allTodosFromdatabase[index];
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
                              decoration: todo.completed
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Checkbox(
                          value: todo.completed,
                          onChanged: (value) => controller.updateTodo(Todo(
                              todo.id,
                              todo.title,
                              todo.completed ? false : true)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    IconButton(
                        onPressed: () async {
                          await controller.deleteTodo(todo.id);
                        },
                        icon: const Icon(
                          Icons.delete,
                          size: 33,
                          color: Colors.red,
                        ))
                  ],
                ),
              ),
            );
          }),
    );
  }
}
