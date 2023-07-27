import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

Future<String> imageCropperWidget(BuildContext context,
    {String? source}) async {
  CroppedFile? croppedfile = await ImageCropper().cropImage(
    sourcePath: source!,
    aspectRatioPresets: [
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio16x9,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio5x3,
      CropAspectRatioPreset.ratio5x4,
      CropAspectRatioPreset.ratio7x5,
      CropAspectRatioPreset.square,
    ],
    uiSettings: [
      AndroidUiSettings(
        toolbarColor: Colors.pink.shade800,
        toolbarTitle: 'Copper',
        toolbarWidgetColor: Colors.white,
        statusBarColor: Colors.pink.shade800,
        lockAspectRatio: false,
      ),
      IOSUiSettings(
        title: 'Cropper',
      ),
      WebUiSettings(
        context: context,
      ),
    ],
  );

  return croppedfile!.path;
}
