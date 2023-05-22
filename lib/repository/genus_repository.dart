import 'dart:convert';
import 'dart:io';

import 'package:biodiv/model/genus/add_data_genus.dart';
import 'package:biodiv/model/genus/delele_genus_model.dart';
import 'package:biodiv/model/genus/get_data_genus.dart';
import 'package:biodiv/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class GenusRepository {
  Future<GetGenusModel> getGenusData() async {
    try {
      final url = Uri.parse('$baseUrl/genus');
      http.Response response = await http.get(url);
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final result = GetGenusModel.fromJson(json);
        return result;
      } else {
        final result = GetGenusModel.fromJson(json);
        return result;
      }
    } catch (error) {
      final result =
          GetGenusModel(error: true, message: error.toString(), data: []);
      return result;
    }
  }

  Future<GetDetailGenusModel> getDetailGenusData(int idGenus) async {
    try {
      final url = Uri.parse('$baseUrl/genus/$idGenus');
      http.Response response = await http.get(url);

      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final result = GetDetailGenusModel.fromJson(json);
        return result;
      } else {
        final result = GetDetailGenusModel.fromJson(json);
        return result;
      }
    } catch (error) {
      final result = GetDetailGenusModel(
          error: true, message: error.toString(), data: null);
      return result;
    }
  }

  Future<DeleteGenusModel> deleteGenusData(int idGenus) async {
    try {
      final url = Uri.parse('$baseUrl/genus/$idGenus');
      http.Response response = await http.delete(url);

      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final result = DeleteGenusModel.fromJson(json);
        return result;
      } else {
        final result = DeleteGenusModel.fromJson(json);
        return result;
      }
    } catch (error) {
      final result = DeleteGenusModel(error: true, message: error.toString());
      return result;
    }
  }

  Future<AddDataGenusModel> addGenusRepository(
      int idFamili,
      String latinName,
      String commonName,
      String character,
      String description,
      XFile? image) async {
    try {
      final url = Uri.parse('$baseUrl/genus');
      final request = http.MultipartRequest('POST', url);

      request.fields['nama_latin'] = latinName;
      request.fields['nama_umum'] = commonName;
      request.fields['ciri_ciri'] = character;
      request.fields['keterangan'] = description;
      request.fields['id_famili'] = idFamili.toString();

      if (image != null) {
        final imageFile = File(image.path);

        final imageField =
            await http.MultipartFile.fromPath('image', imageFile.path);

        request.files.add(imageField);
      }

      var response = await request.send();

      var responseBody = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        final json = jsonDecode(responseBody);
        final result = AddDataGenusModel.fromJson(json);
        return result;
      } else {
        final json = jsonDecode(responseBody);
        final result = AddDataGenusModel.fromJson(json);
        return result;
      }
    } catch (error) {
      final result = AddDataGenusModel(error: true, message: error.toString());
      return result;
    }
  }

  Future<AddDataGenusModel> updateGenusRepository(
      int idGenus,
      int idFamili,
      String latinName,
      String commonName,
      String character,
      String description,
      XFile? image) async {
    try {
      final url = Uri.parse('$baseUrl/genus');
      final request = http.MultipartRequest('PUT', url);
      request.fields['id_genus'] = idGenus.toString();
      request.fields['nama_latin'] = latinName;
      request.fields['nama_umum'] = commonName;
      request.fields['ciri_ciri'] = character;
      request.fields['keterangan'] = description;
      request.fields['id_famili'] = idFamili.toString();

      if (image != null) {
        final imageFile = File(image.path);

        final imageField =
            await http.MultipartFile.fromPath('image', imageFile.path);

        request.files.add(imageField);
      }

      var response = await request.send();

      var responseBody = await response.stream.bytesToString();
      print(responseBody);
      if (response.statusCode == 200) {
        final json = jsonDecode(responseBody);
        final result = AddDataGenusModel.fromJson(json);
        return result;
      } else {
        final json = jsonDecode(responseBody);
        final result = AddDataGenusModel.fromJson(json);
        return result;
      }
    } catch (error) {
      final result = AddDataGenusModel(error: true, message: error.toString());
      return result;
    }
  }
}
