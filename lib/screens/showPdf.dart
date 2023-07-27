import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ShowPdfFile extends StatefulWidget {
  final String path;
  const ShowPdfFile({Key? key, required this.path}) : super(key: key);

  @override
  State<ShowPdfFile> createState() => _ShowPdfFileState();
}

class _ShowPdfFileState extends State<ShowPdfFile> {
  late PdfViewerController pdfViewerController;
  late Uint8List pdfReader;

  Future<Uint8List> readPdf() async {
    File file = File(widget.path);
    pdfReader = await file.readAsBytes();
    return pdfReader;
  }

  @override
  void initState() {
    super.initState();
    pdfViewerController = PdfViewerController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
            },
          ),
        ),
        body: FutureBuilder<Uint8List>(
          future: readPdf(),
          builder: (context, AsyncSnapshot<Uint8List> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SfPdfViewer.memory(snapshot.data!);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
