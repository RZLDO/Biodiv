import 'package:image_picker/image_picker.dart';

class ImageResource {
  static Future<XFile?> getImageData() async {
    final imagePicker = ImagePicker();
    final pickedImage = imagePicker.pickImage(source: ImageSource.gallery);
    return pickedImage;
  }
}
