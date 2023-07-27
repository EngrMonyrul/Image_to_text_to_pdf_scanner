import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/quickalert.dart';
import 'package:scanner_app/screens/imageRecognizer.dart';
import 'package:scanner_app/widgets/imageCropper.dart';
import 'package:scanner_app/widgets/modalBottomSheet.dart';
import 'package:scanner_app/widgets/photoPicker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
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
          title: const Text('PDF Convert'),
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontFamily: 'Times new Roman',
            fontSize: 30,
          ),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: screenSize.height * 0.1,
              ),
              Container(
                height: screenSize.height * 0.3,
                width: screenSize.width * 0.7,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/slogo.png'),
                  fit: BoxFit.fill,
                )),
              ),
              Container(
                alignment: Alignment.center,
                height: screenSize.height * 0.05,
                width: screenSize.width * 0.7,
                child: const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Credits - ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          // color: Color.fromARGB(255, 123, 255, 0),
                        ),
                      ),
                      TextSpan(
                        text: 'Monirul Islam',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Color.fromARGB(255, 255, 60, 0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.1,
              ),
              Container(
                height: screenSize.height * 0.15,
                width: screenSize.width * 0.8,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: screenSize.height * 0.075,
                      width: screenSize.width * 0.8,
                      child: Text(
                        "\'Photo To Text Converter\'",
                        style: TextStyle(
                          fontSize: 23,
                          color: Colors.blueGrey.shade900,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: screenSize.height * 0.075,
                      width: screenSize.width * 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: screenSize.height * 0.75,
                            width: screenSize.width * 0.3,
                            child: ElevatedButton(
                              style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.red)),
                              autofocus: true,
                              onPressed: () {
                                setState(
                                  () {
                                    QuickAlert.show(
                                      context: context,
                                      autoCloseDuration:
                                          const Duration(seconds: 5),
                                      showCancelBtn: true,
                                      title: 'Wanna Exit?',
                                      text: 'This is a cool app, try it!',
                                      type: QuickAlertType.confirm,
                                      confirmBtnColor: Colors.red,
                                      confirmBtnText: 'Yes',
                                      cancelBtnText: 'No',
                                      cancelBtnTextStyle: const TextStyle(
                                        color: Colors.green,
                                      ),
                                      onConfirmBtnTap: () {
                                        SystemNavigator.pop();
                                        setState(() {});
                                      },
                                    );
                                  },
                                );
                              },
                              child: const Text(
                                'Exit',
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: screenSize.height * 0.75,
                            width: screenSize.width * 0.3,
                            child: ElevatedButton(
                              style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Colors.greenAccent),
                              ),
                              autofocus: true,
                              onPressed: () {
                                String mainImagePath = '';
                                setState(
                                  () {
                                    ModalBottomSheet(context, tapOnCamera: () {
                                      getPhotos(ImageSource.camera).then(
                                        (value) {
                                          mainImagePath = value;
                                          imageCropperWidget(context,
                                                  source: value)
                                              .then(
                                            (value) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ImageRecognizer(
                                                    source: value,
                                                    mainImg: mainImagePath,
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      );
                                    }, tapOnGallery: () {
                                      getPhotos(ImageSource.gallery).then(
                                        (value) {
                                          imageCropperWidget(context,
                                                  source: value)
                                              .then(
                                            (value) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ImageRecognizer(
                                                    source: value,
                                                    mainImg: mainImagePath,
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      );
                                    }, screenSize: screenSize);
                                  },
                                );
                              },
                              child: const Text(
                                'Photo',
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
