import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Storage {
  Future<String> get _localPath async {
    final _path = await getApplicationDocumentsDirectory();//getTemporaryDirectory();
    return _path.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;

    return File('$path/sketck.txt');
  }

  Future<String> read() async {
    try {
      final file = await _localFile;

      var contents = await file.readAsString();

      return contents;
    } catch (e) {
      return null;
    }
  }

  Future<File> write(counter) async {
    final file = await _localFile;

    return file.writeAsString('$counter');
  }
}
