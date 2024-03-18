import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/presentation/pages/intern/bai3/bai3_controller.dart';


class AddTaskPage extends GetView<Bai3Controller>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("ADD TASK"),
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(CupertinoIcons.back, color: Colors.white,)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        controller: controller.editingController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Title'),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your task title';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.addTodo(controller.editingController.text);
                        controller.editingController.clear();
                        Get.back();
                      },
                      child: Center(
                        child: Text(
                          "Confirm",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueGrey,
                        minimumSize: Size(110, 60),

                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}