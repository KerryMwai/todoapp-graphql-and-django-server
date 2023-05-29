import 'package:get/get.dart';
import 'package:todo_app/core/controller/todo_controller.dart';

Future<void> init()async{
  Get.lazyPut(() => TodoController());
}