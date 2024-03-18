
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareService {
  Future<void> onShareFiles(BuildContext context,
      {required List<String> filePaths, List<String>? fileNames, String? text, String? subject}) async {
    final box = context.findRenderObject() as RenderBox?;

    if (filePaths.isNotEmpty) {
      final files = <XFile>[];
      for (var i = 0; i < filePaths.length; i++) {
        files.add(XFile(filePaths[i], name: fileNames == null ? null : fileNames[i]));
      }
      await Share.shareXFiles(files,
          text: text, subject: subject, sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    }
  }
}
