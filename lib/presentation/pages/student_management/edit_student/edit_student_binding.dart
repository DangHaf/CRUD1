import 'package:get/get.dart';
import 'package:template/presentation/pages/student_management/edit_student/edit_student_controller.dart';

class EditStudentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditStudentController>(() => EditStudentController());
  }
}
