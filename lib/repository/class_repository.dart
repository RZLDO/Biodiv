import 'dart:convert';
import 'dart:io';

import 'package:biodiv/model/detail_class_model.dart';
import 'package:biodiv/model/get_class_model.dart';
import 'package:biodiv/model/get_ordo_model.dart';
import 'package:biodiv/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ClassRepository {
  Future<GetDataClass> getDataClass() async {
    try {
      final url = Uri.parse('$baseUrl/class');
      http.Response response = await http.get(url);
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final dataClass = GetDataClass.fromJson(json);
        return dataClass;
      } else {
        final dataClass = GetDataClass.fromJson(json);
        return dataClass;
      }
    } catch (error) {
      final errorResponse =
          GetDataClass(error: true, message: error.toString(), data: []);
      return errorResponse;
    }
  }

  Future<AddClassDataModel> addClassData(
    String latinName,
    String commonName,
    String characteristics,
    String description,
    XFile? image,
  ) async {
    try {
      final url = Uri.parse('$baseUrl/class');

      // Create a multipart request
      var request = http.MultipartRequest('POST', url);

      // Add fields to the request
      request.fields['nama_latin'] = latinName;
      request.fields['nama_umum'] = commonName;
      request.fields['ciri_ciri'] = characteristics;
      request.fields['keterangan'] = description;

      // Convert XFile to File
      if (image != null) {
        var imageFile = File(image.path);

        // Add the image file to the request
        var imageField =
            await http.MultipartFile.fromPath('image', imageFile.path);
        request.files.add(imageField);
      }

      // Send the request
      var response = await request.send();

      // Get the response body
      var responseBody = await response.stream.bytesToString();

      // Check the response status
      if (response.statusCode == 200) {
        // Image uploaded successfully
        var json = jsonDecode(responseBody);
        var result = AddClassDataModel.fromJson(json);
        return result;
      } else {
        // Failed to upload image
        var json = jsonDecode(responseBody);
        var result = AddClassDataModel.fromJson(json);
        return result;
      }
    } catch (error) {
      var result = AddClassDataModel(error: true, message: error.toString());
      return result;
    }
  }

  Future<DetailResponse> getDetailClass(int id) async {
    try {
      final url = Uri.parse('$baseUrl/class/{$id}');
      http.Response response = await http.post(url);
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final response = DetailResponse.fromJson(json);
        return response;
      } else {
        final response = DetailResponse.fromJson(json);
        return response;
      }
    } catch (error) {
      final response =
          DetailResponse(error: true, message: error.toString(), data: null);
      return response;
    }
  }
}
