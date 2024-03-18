
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Bai3Controller extends GetxController{
  final formKey = GlobalKey<FormState>();
  final TextEditingController editingController = TextEditingController();

  var todoList = [].obs;

  addTodo(String todo) {
    todoList.add(todo);
    print("Thêm thành công task");
  }


  deleteTodo(int index) {
    todoList.removeAt(index);
    print("Xóa thành công task tại index $index");
  }
}