import 'package:get/get.dart';
import 'package:template/presentation/pages/student_management/student_management_controller.dart';

class StudentManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentManagementController>(
        () => StudentManagementController());
  }
}
