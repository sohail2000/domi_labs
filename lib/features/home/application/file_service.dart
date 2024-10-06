import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class FileService {
  static Future<File> _copyJsonFileToLocalDir() async {
  // Get the directory where you can store the local database.
  final directory = await getApplicationDocumentsDirectory();
  final path = '${directory.path}/files_data.json';

  // Check if the file exists, if not copy it from assets.
  final File file = File(path);
  if (!(await file.exists())) {
    // Load the file from assets
    final String data = await rootBundle.loadString('assets/store/files_data.json');
    await file.writeAsString(data);
  }
  return file;
}
}