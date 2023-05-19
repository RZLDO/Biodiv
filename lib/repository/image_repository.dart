import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../utils/constant.dart';

class ImageResource {
  static Future<XFile?> getImageData() async {
    final imagePicker = ImagePicker();
    final pickedImage = imagePicker.pickImage(source: ImageSource.gallery);
    return pickedImage;
  }

  static Future getImageFileFromNetwork(String imageUrl) async {
    try {
      var response = await http.get(Uri.parse('$baseUrl/image/$imageUrl'));
      if (response.statusCode == 200) {
        final tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/$imageUrl');

        await file.writeAsBytes(response.bodyBytes);

        return XFile(file.path);
      } else {
        throw Exception('Failed to download image');
      }
    } catch (error) {
      throw Exception('Error converting image URL to file: $error');
    }
  }
}
