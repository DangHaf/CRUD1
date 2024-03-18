import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

class Bai2Controller extends GetxController{
  final formKey = GlobalKey<FormState>();
  final TextEditingController aController = TextEditingController();
  final TextEditingController bController = TextEditingController();
  final TextEditingController cController = TextEditingController();

  var a = 0.0.obs;
  var b = 0.0.obs;
  var c = 0.0.obs;
  var result = ''.obs;

  void tinhKetQua() {
    double delta = b.value * b.value - 4 * a.value * c.value;
    if (delta < 0) {
      result.value = 'Phương trình vô nghiệm';
    } else if (delta == 0) {
      double nghiemKep = -b.value / (2 * a.value);
      result.value = 'Nghiệm kép: \n$nghiemKep';
    } else {
      double nghiem1 = (-b.value + sqrt(delta)) / (2 * a.value);
      double nghiem2 = (-b.value - sqrt(delta)) / (2 * a.value);
      result.value = 'Nghiệm của phương trình là:\n x1= $nghiem1\nx2= $nghiem2';
    }
  }

}