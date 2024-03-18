import 'package:get/get.dart';
import 'package:template/presentation/pages/student_management/add_student/add_student_controller.dart';

class AddStudentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddStudentController>(() => AddStudentController());
  }
}
