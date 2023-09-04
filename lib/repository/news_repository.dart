import 'dart:convert';
import 'dart:io';

import 'package:biodiv/model/News%20Model/news_model.dart';
import 'package:biodiv/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class NewsRepository {
  Future<GetNewsModel> getNews() async {
    try {
      final url = Uri.parse('$baseUrl/news');
      http.Response response = await http.get(url);
      final json = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return GetNewsModel.fromJson(json);
      } else {
        return GetNewsModel.fromJson(json);
      }
    } catch (error) {
      return GetNewsModel(
          error: true, message: error.toString(), newsResult: []);
    }
  }

  Future<BaseNewsResult> addNews(
      String judulBerita, String deskripsi, String webUrl, XFile? image) async {
    try {
      final url = Uri.parse('$baseUrl/news');
      var request = http.MultipartRequest('POST', url);

      request.fields['judul'] = judulBerita;
      request.fields['deskripsi'] = deskripsi;
      request.fields['url_web'] = webUrl;

      if (image != null) {
        var imageFile = File(image.path);
        var imageField =
            await http.MultipartFile.fromPath('image', imageFile.path);
        request.files.add(imageField);
      }

      var response = await request.send();

      var responseBody = await response.stream.bytesToString();

      // Check the response status
      if (response.statusCode == 200) {
        // Image uploaded successfully
        var json = jsonDecode(responseBody);
        var result = BaseNewsResult.fromJson(json);
        return result;
      } else {
        var json = jsonDecode(responseBody);
        var result = BaseNewsResult.fromJson(json);
        return result;
      }
    } catch (error) {
      var result = BaseNewsResult(error: true, message: error.toString());
      return result;
    }
  }

  Future<BaseNewsResult> deleteNews(int idBerita) async {
    try {
      final url = Uri.parse('$baseUrl/news/$idBerita');
      http.Response response = await http.delete(url);
      final json = jsonDecode(response.body);
      return BaseNewsResult.fromJson(json);
    } catch (error) {
      return BaseNewsResult(error: true, message: error.toString());
    }
  }
}
