import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:quickalert/quickalert.dart';
import 'package:scanner_app/screens/showPdf.dart';
import 'package:scanner_app/utils/pdfConverter.dart';

class ImageRecognizer extends StatefulWidget {
  final String source;
  final String mainImg;
  const ImageRecognizer({Key? key, required this.source, required this.mainImg})
      : super(key: key);

  @override
  State<ImageRecognizer> createState() => _ImageRecognizerState();
}

class _ImageRecognizerState extends State<ImageRecognizer> {
  final TextEditingController textEditingController = TextEditingController();
  final path = '';

  bool isBusy = false;

  proccessImage(InputImage inputImage) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    setState(() {
      isBusy = true;
    });

    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    textEditingController.text = recognizedText.text;

    setState(() {
      isBusy = false;
    });
  }

  @override
  void initState() {
    super.initState();
    final InputImage image = InputImage.fromFilePath(widget.source);
    proccessImage(image);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/images/mobile-wallpaper-with-fluid-shapes_79603-599.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 10,
                      sigmaY: 10,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: MediaQuery.of(context).size.width * 0.9,
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: isBusy != true
                          ? TextField(
                              maxLines: null,
                              controller: textEditingController,
                              decoration: const InputDecoration(
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                              ),
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: ElevatedButton(
                          style: const ButtonStyle(
                            alignment: Alignment.center,
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.red),
                          ),
                          onPressed: () {
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                          child: const Text(
                            'Back',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            alignment: Alignment.center,
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.teal.shade600),
                          ),
                          onPressed: () {
                            setState(() {
                              pdfConverter(
                                      textEditingController.text, widget.source)
                                  .then((pdfPath) {
                                QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.confirm,
                                    confirmBtnText: 'Yes',
                                    cancelBtnText: 'No',
                                    title: 'Show PDF?',
                                    onConfirmBtnTap: () {
                                      setState(() {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ShowPdfFile(path: pdfPath),
                                          ),
                                        );
                                      });
                                    });
                              });
                            });
                          },
                          child: const Text(
                            'Convert',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
