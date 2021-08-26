import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

class ReadOrWriteImages {
  static void writeImageBytesToFile(
      Uint8List imageBytes, String filename) async {
    File file = File(await getFilePath(filename));
    file.writeAsBytesSync(imageBytes);
  }

  static Future<String> getFilePath(String filename) async {
    Directory appDocumentsDirectory = await getTemporaryDirectory();
    String appDocumentsPath = appDocumentsDirectory.path;
    String filePath = '$appDocumentsPath/$filename';
    return filePath;
  }

  static Future<Uint8List> getImageContent(String filename) async {
    File file = File(await getFilePath(filename));
    Uint8List fileContent = await file.readAsBytes();
    return fileContent;
  }
}
