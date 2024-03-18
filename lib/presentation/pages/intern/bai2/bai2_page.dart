import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/presentation/pages/intern/bai2/bai2_controller.dart';

class Bai2Page extends GetView<Bai2Controller> {
  const Bai2Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,top: 50),
        child: Column(
          children: [
            Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              controller.result.value != 0
                                  ? '${controller.result.value}'
                                  : '0',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 22),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  TextField(
                    controller: controller.aController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        controller.a.value = double.parse(value);
                      } else {
                        const AlertDialog(
                          content: Text("Vui lòng nhập hệ số a"),
                        );
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: "Nhập số a",
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: controller.bController,
                    onChanged: (value) {
                      controller.b.value = double.parse(value);
                    },
                    decoration: const InputDecoration(
                      labelText: "Nhập số B",
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: controller.cController,
                    onChanged: (value) {
                      controller.c.value = double.parse(value);
                    },
                    decoration: const InputDecoration(
                      labelText: "Nhập số C",
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        controller.tinhKetQua();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Giải"),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
