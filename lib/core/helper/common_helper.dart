import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:template/core/export/core_export.dart';
import 'dart:io';
import 'dart:math';
import 'package:image/image.dart' as img;
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;
import 'package:tiengviet/tiengviet.dart';
import 'package:url_launcher/url_launcher.dart';

mixin CommonHelper {
  static Future<void> onTapHandler({required Function callback}) async {
    callback();
  }

  static String htmlUnescape(String htmlString) {
    final unescape = HtmlUnescape();
    return unescape.convert(htmlString);
  }

  static void primaryFocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static Future<Uint8List> resizeImage(String imageUrl) async {
    Uint8List originalUnit8List;
    final http.Response response = await http.get(Uri.parse(imageUrl));
    originalUnit8List = response.bodyBytes;

    final codec = await ui.instantiateImageCodec(originalUnit8List, targetHeight: 1280, targetWidth: 1280);
    final frameInfo = await codec.getNextFrame();
    final ui.Image targetUiImage = frameInfo.image;

    final ByteData? targetByteData = await targetUiImage.toByteData(format: ui.ImageByteFormat.png);
    return targetByteData!.buffer.asUint8List();
  }

  static List<BoxShadow> boxShadow = [
    BoxShadow(
      offset: const Offset(0, 2),
      blurRadius: 15,
      color: ColorResources.OUTER_SPACE.withAlpha(10),
    ),
    BoxShadow(
      offset: const Offset(0, -2),
      blurRadius: 15,
      color: ColorResources.OUTER_SPACE.withAlpha(10),
    ),
    BoxShadow(
      offset: const Offset(2, 0),
      blurRadius: 15,
      color: ColorResources.OUTER_SPACE.withAlpha(10),
    ),
    BoxShadow(
      offset: const Offset(-2, 0),
      blurRadius: 15,
      color: ColorResources.OUTER_SPACE.withAlpha(10),
    ),
  ];

  static String covertNumberToK({required num value}) {
    final List<String> unitMoney = ['', 'K', 'M'];
    int position = 0;
    late double _result;

    if (value <= 1000) {
      return value.toString();
    }
    if (value < 1000000) {
      position = 1;
      _result = value / 1000;
      return '${_result.toStringAsFixed(1)}${unitMoney[position]}';
    } else {
      position = 2;
      _result = value / 1000000;
      return '${_result.toStringAsFixed(1)}${unitMoney[position]}';
    }
  }

  static String byteToString(int bytes, {int? decimals = 2}) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    final i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals!)} ${suffixes[i]}';
  }

  static Future<String> getFileSize(String filepath, {int? decimals = 2}) async {
    final file = File(filepath);
    final int bytes = await file.length();
    return byteToString(bytes, decimals: decimals);
  }

  static Future<String?> downLoadFile({required String urlFile}) async {
    final Dio _dio = Dio();
    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
    final filePath = '${appDocumentsDirectory.path}/AudioDownload${DateTime.now().microsecondsSinceEpoch}.mp3';

    try {
      await _dio.download(urlFile, filePath);

      dev.log('File downloaded to: $filePath');

      return filePath;
    } catch (e) {
      dev.log('Download error: $e');
    }
    return null;
  }

  static Future<File> fixImageOrientation(File imageFile) async {
    final imageBytes = await imageFile.readAsBytes();
    final image = img.decodeImage(imageBytes);

    img.Image fixedImage;
    if (image!.width > image.height) {
      fixedImage = img.copyRotate(image, angle: -90);
    } else {
      fixedImage = img.copyRotate(image, angle: 0);
    }

    final fixedImageFile = File(imageFile.path);
    fixedImageFile.writeAsBytesSync(img.encodeJpg(fixedImage));
    return fixedImageFile;
  }

  static String convertDurationToToTime(Duration duration, {bool isShowHour = false}) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (duration.inHours == 0 && !isShowHour) {
      return "$twoDigitMinutes:$twoDigitSeconds";
    }

    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  static String toSlug({required String text}) {
    final textSlug = TiengViet.parse(text.toLowerCase()).replaceAll(' ', '-');
    return textSlug;
  }
  ///
  /// Generate padding horizontal package description.
  ///
  static double generatePaddingHorizontalPackageDescription() {
    if (IZISizeUtil.getTypeOfDevice() == TypeOfDevice.bigDevice) {
      return IZISizeUtil.setSizeWithWidth(percent: .25);
    }
    if (IZISizeUtil.getTypeOfDevice() == TypeOfDevice.mediumSmallDevice) {
      return IZISizeUtil.setSizeWithWidth(percent: .3);
    }
    if (IZISizeUtil.getTypeOfDevice() == TypeOfDevice.smallDevice) {
      return IZISizeUtil.setSizeWithWidth(percent: .35);
    }
    return IZISizeUtil.setSizeWithWidth(percent: .27);
  }

  ///
  /// Get premium end date.
  ///
  static DateTime getPremiumEndDate({required DateTime startDate, required String idPurchase}) {
    switch (idPurchase) {
      case IdSubscription.monthlyId:
        return startDate.add(const Duration(days: 30));
      case IdSubscription.lifeTimeId:
        return DateTime(
            startDate.year + 1, startDate.month, startDate.day, startDate.hour, startDate.minute, startDate.second);
      default:
        return startDate.add(const Duration(days: 7));
    }
  }

  ///
  /// Get premium end date.
  ///
  static Future<String> getAudioFromVideo(Uint8List videoData) async {
    final path = await getApplicationDocumentsDirectory();
    final sampleVideo = "${path.path}/sample_video.mp4";

    final File _avFile = await File(sampleVideo).create();
    await _avFile.writeAsBytes(videoData);

    final String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    final String sampleAudio = '${path.path}/$timeStamp.mp3';
    final File audioFile = await _avFile.copy(sampleAudio);
    return audioFile.path;
  }

  static Future<void> iziLaunchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url)).then((value) {
      return value;
    })) {
      throw Exception('Could not launch $url');
    }
  }

  static double distanceBetween(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    const earthRadius = 6378137.0;
    final dLat = _toRadians(endLatitude - startLatitude);
    final dLon = _toRadians(endLongitude - startLongitude);

    final a =
        pow(sin(dLat / 2), 2) + pow(sin(dLon / 2), 2) * cos(_toRadians(startLatitude)) * cos(_toRadians(endLatitude));
    final c = 2 * asin(sqrt(a));

    return earthRadius * c;
  }

  static double _toRadians(double degree) {
    return degree * pi / 180;
  }

  static LinearGradient backGroundScaffold = LinearGradient(
    colors: [
      const Color(0xFF002E00),
      const Color(0xFF002400).withOpacity(.33),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
