import 'package:image_picker/image_picker.dart';

Future<String> getPhotos(ImageSource source) async {
  ImagePicker imagePicker = ImagePicker();

  final image = await imagePicker.pickImage(source: source);

  if (image != null) {
    return image.path;
  } else {
    return '';
  }
}
