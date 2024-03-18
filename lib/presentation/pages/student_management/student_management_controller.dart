import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/core/helper/izi_alert.dart';
import 'package:template/data/model/student/student_model.dart';
import 'package:template/data/repositories/student_repositories.dart';

class StudentManagementController extends GetxController {
  RxInt selectedIndex = 0.obs;
  final StudentRepository _studentRepository = GetIt.I.get<StudentRepository>();
  RxList<StudentModel> listStudents = <StudentModel>[].obs;
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    getAllStudents();
    super.onInit();
  }

  List<String> tabList = ['Students', 'Subject', 'Evaluation', 'Event'];

  void selectTab(int index) {
    selectedIndex.value = index;
  }

  Future<void> getAllStudents() async {
    await _studentRepository.getAllStudent(
      onSuccess: (data) {
        listStudents.assignAll(data);
      },
      onError: (_) {},
    );
  }

  Future<void> deleteStudent(String id) async {
    _isLoading.value = true;
    await _studentRepository.deleteStudent(
        id: id,
        onSuccess: () {
          getAllStudents();
        },
        onError: (error) {
          EasyLoading.dismiss();
          IZIAlert().error(message: error.toString());
        });
    _isLoading.value = false;
    EasyLoading.dismiss();
  }
}
