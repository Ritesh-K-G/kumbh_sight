import 'dart:io';
import 'package:path_provider/path_provider.dart';
Future<String> getLocalPath()async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}
Future<File> getLocalFile(String file)async {
  final path = await getLocalPath();
  return File('$path/notifications.txt');
}
Future<File> writeFile(String fileName, String message) async {
  final file = await getLocalFile(fileName);
  return file.writeAsString(message);
}
Future<String> readFile(String fileName) async {
  try {
    final file = await getLocalFile(fileName);
    final contents = await file.readAsString();
    return contents;
  } catch (e) {
    return 'null';
  }
}