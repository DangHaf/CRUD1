import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/presentation/pages/intern/bai1/bai1_controller.dart';

class Bai1Page extends GetView<Bai1Controller> {
  const Bai1Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 50),
        child: Column(
          children: [
            Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                                  ? "Nghiem cua phuong trinh la : x = " +
                                      '${controller.result.value}'
                                  : '0',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 18),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  TextField(
                    controller: controller.sAController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      controller.a.value = double.parse(value);
                    },
                    decoration: const InputDecoration(
                      labelText: "Nhập số a",
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: controller.sBController,
                    onChanged: (value) {
                      controller.b.value = double.parse(value);
                    },
                    decoration: const InputDecoration(
                      labelText: "Nhập số B",
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        controller.tinhKetQua();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text("Giải"),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
