import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/core/helper/izi_alert.dart';
import 'package:template/data/model/student/student_request.dart';
import 'package:template/data/repositories/student_repositories.dart';
import 'package:template/presentation/pages/student_management/student_management_controller.dart';

class AddStudentController extends GetxController {
  final StudentRepository studentRepository = GetIt.I.get<StudentRepository>();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController classController = TextEditingController();
  TextEditingController studentIdController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController averageController = TextEditingController();
  RxList<String> listSelectedSubject = <String>[].obs;

  void saveSelectedSubjects(List<String> selectedSubjects) {
    listSelectedSubject.assignAll(selectedSubjects);
  }

  Future<void> addStudent() async {
    final ContactAddInfoRequest contactInfo = ContactAddInfoRequest(
      address: addressController.text,
      email: emailController.text,
      phoneNumber: phoneController.text,
    );

    final AddStudentRequest addStudentRequest = AddStudentRequest(
        contactInfo: contactInfo,
        registeredCourses: listSelectedSubject,
        averageScore: double.parse(averageController.text),
        dateOfBirth: int.parse(dateController.text),
        classInfo: classController.text,
        fullName: fullnameController.text);

    await studentRepository.addStudent(
        data: addStudentRequest,
        onSuccess: () {
          final studentController = Get.find<StudentManagementController>();
          studentController.getAllStudents();
        },
        onError: (error) {
          EasyLoading.dismiss();
          IZIAlert().error(message: error.toString());
        });
    EasyLoading.dismiss();
  }
}
