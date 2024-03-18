import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/presentation/pages/intern/bai3/add_task/add_task_page.dart';
import 'package:template/presentation/pages/intern/bai3/bai3_controller.dart';
import 'package:template/presentation/pages/intern/bai3/widgets/dott_add.dart';

class Bai3Page extends GetView<Bai3Controller> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const SizedBox(height: 50),
          const Text(
            "Danh sách công việc",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.todoList.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 200,
                    height: 50,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[600]!,
                          blurRadius: 10,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                controller.todoList[index],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.black),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Get.defaultDialog(
                                  title: "Confirm Delete",
                                  middleText:
                                      "Are you sure you want to delete this task?",
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        controller.deleteTodo(index);
                                        Get.back();
                                      },
                                      child: Text('Yes'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text('No'),
                                    ),
                                  ],
                                );
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            child: InkWell(
              onTap: () {
                Get.to(() => AddTaskPage());
              },
              child: CustomPaint(
                painter: Dotted(),
                child: Container(
                  width: 100,
                  height: 100,
                  alignment: Alignment.center,
                  child: Icon(Icons.add, color: Colors.black, size: 50),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
