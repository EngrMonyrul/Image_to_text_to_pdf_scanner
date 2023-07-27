import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:path/path.dart';

Future<String> pdfConverter(String textFile, String imagePath) async {
  final pdf = Document();
  int index = 0;
  pdf.addPage(
    Page(
      build: (context) {
        return Container(
          alignment: Alignment.topLeft,
          child: Text(textFile),
        );
      },
    ),
  );
  final dir = await getExternalStorageDirectory();

  index++;
  final bytes = await pdf.save();
  final name = basename(imagePath);
  final name2 = name.replaceAll('.jpg', '$index');
  final file = File('${dir!.path}/$name2.pdf');

  print(file);
  await file.writeAsBytes(bytes);
  return file.path;
}
