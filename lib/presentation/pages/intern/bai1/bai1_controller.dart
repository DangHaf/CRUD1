import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Bai1Controller extends GetxController {
  final TextEditingController sAController = TextEditingController();
  final TextEditingController sBController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var a = 0.0.obs;
  var b = 0.0.obs;
  var result = 0.0.obs;

  void tinhKetQua() {
    if (a.value != 0) {
      result.value = -b.value / a.value;
    } else {
      result.value = double.infinity;
    }
    print(result);
  }

}
