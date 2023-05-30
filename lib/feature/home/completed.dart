import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/core/controller/todo_controller.dart';

class CompletedTodos extends StatefulWidget {
  const CompletedTodos({super.key});

  @override
  State<CompletedTodos> createState() => _CompletedTodosState();
}

class _CompletedTodosState extends State<CompletedTodos> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodoController>(
      builder:(controller)=> GridView.builder(
          itemCount: controller.completedTodos.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2 / 3),
          itemBuilder: (context, index) {
            final todo = controller.completedTodos[index];
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
                      height: 30,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Completed",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                            color: Colors.green
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
