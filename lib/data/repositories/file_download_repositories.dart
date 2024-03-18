import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';

import '../data_source/dio/dio_client.dart';

class FileDownloadRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  FileDownloadRepository();

  ///
  /// Download audio
  ///
  Future<String?> downloadAudio(String url) async {
    try {
      final String appPath = (await getApplicationDocumentsDirectory()).path;
      final String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
      final String savePath = '$appPath/audio/$timeStamp.mp3';
      await dioClient!.downloadFile(uri: url, path: savePath);
      return savePath;
    } catch (e) {
      print("truong Error catch $e");
      return null;
    }
  }
}
