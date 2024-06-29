import 'dart:convert';
import 'dart:io';

class FileLoader {
  Future<Map<String, dynamic>> loadFile(String path) async {
    final file = File(path);
    final contents = file.readAsStringSync();
    return jsonDecode(contents) as Map<String, dynamic>;
  }
}
