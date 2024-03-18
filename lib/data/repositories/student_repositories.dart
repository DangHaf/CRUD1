import 'package:template/core/export/core_export.dart';
import 'package:template/data/data_source/dio/dio_client.dart';
import 'package:template/data/data_source/exception/api_error_handler.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/student/student_model.dart';
import 'package:template/data/model/student/student_request.dart';
import 'package:template/domain/end_points/end_point.dart';

class StudentRepository {
  final _dio = sl.get<DioClient>();

  Future<void> getAllStudent(
      {required Function(List<StudentModel> data) onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      final response = await _dio.get(EndPoint.STUDENT);

      print('');
      final results = response.data as List<dynamic>;
      onSuccess(results
          .map((e) => StudentModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> updateStudent(
      {required String id,
      required UpdateStudentRequest data,
      required Function() onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      await _dio.put('${EndPoint.STUDENT}/$id', data: data.toJson());
      onSuccess();
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> addStudent(
      {required AddStudentRequest data,
      required Function() onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      await _dio.post('${EndPoint.STUDENT}/', data: data.toJson());
      onSuccess();
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> deleteStudent(
      {required String id,
      required Function() onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      await _dio.delete('${EndPoint.STUDENT}/$id');
      onSuccess();
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }
}
