import 'dart:developer';
import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart';

class PdfApi {
  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();
    //log(bytes.toString());

    //final dir = await getApplicationDocumentsDirectory();
    //log(dir.toString());
   // final path=Directory('');
    
    final file = File('/storage/emulated/0/Download/$name');

    await file.writeAsBytes(bytes).then((value) {log('writecomplte'); OpenFile.open(file.path);
    });
    log('return');
    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;
    log(url);
    await OpenFile.open(url);
  }
}
