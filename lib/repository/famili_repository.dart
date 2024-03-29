import 'dart:convert';
import 'dart:io';

import 'package:biodiv/model/famili%20model/add_famili_model.dart';
import 'package:biodiv/model/famili%20model/delete_famili.dart';
import 'package:biodiv/model/famili%20model/detai_famili_mode.dart';
import 'package:biodiv/model/famili%20model/famili_model.dart';
import 'package:biodiv/model/famili%20model/update_famili_model.dart';
import 'package:biodiv/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class FamiliRepository {
  Future<FamiliResponseModel> getFamiliByOrdo(int idOrdo, int? page) async {
    try {
      final url = page == 0
          ? Uri.parse('$baseUrl/famili/ordo/?id_ordo=$idOrdo')
          : Uri.parse('$baseUrl/famili/ordo/?id_ordo=$idOrdo&page=$page');
      http.Response response = await http.get(url);

      final json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final result = FamiliResponseModel.fromJson(json);
        return result;
      } else {
        final result = FamiliResponseModel.fromJson(json);
        return result;
      }
    } catch (error) {
      final result =
          FamiliResponseModel(error: true, message: error.toString(), data: []);
      return result;
    }
  }

  Future<FamiliResponseModel> getFamiliData() async {
    try {
      final url = Uri.parse('$baseUrl/famili');
      http.Response response = await http.get(url);

      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final result = FamiliResponseModel.fromJson(json);
        return result;
      } else {
        final result = FamiliResponseModel.fromJson(json);
        return result;
      }
    } catch (error) {
      final result =
          FamiliResponseModel(error: true, message: error.toString(), data: []);
      return result;
    }
  }

  Future<FamiliDetailModel> getDetailFamiliData(int idFamili) async {
    try {
      final url = Uri.parse('$baseUrl/famili/$idFamili');
      http.Response response = await http.get(url);

      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final result = FamiliDetailModel.fromJson(json);
        return result;
      }
      {
        final result = FamiliDetailModel.fromJson(json);
        return result;
      }
    } catch (error) {
      final result =
          FamiliDetailModel(error: true, message: error.toString(), data: null);
      return result;
    }
  }

  Future<DeleteFamiliModel> deletFamili(int idFamili) async {
    try {
      final url = Uri.parse('$baseUrl/famili/$idFamili');
      http.Response response = await http.delete(url);
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final result = DeleteFamiliModel.fromJson(json);
        return result;
      } else {
        final result = DeleteFamiliModel.fromJson(json);
        return result;
      }
    } catch (error) {
      final result = DeleteFamiliModel(error: true, message: error.toString());

      return result;
    }
  }

  Future<AddFamiliModel> addFamiliData(
    int idOrdo,
    String latinName,
    String commonName,
    String character,
    String description,
    XFile? image,
  ) async {
    try {
      final url = Uri.parse('$baseUrl/famili');
      final request = http.MultipartRequest('POST', url);

      request.fields['nama_latin'] = latinName;
      request.fields['nama_umum'] = commonName;
      request.fields['ciri_ciri'] = character;
      request.fields['keterangan'] = description;
      request.fields['id_ordo'] = idOrdo.toString();

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
        final result = AddFamiliModel.fromJson(json);
        return result;
      } else {
        final json = jsonDecode(responseBody);
        final result = AddFamiliModel.fromJson(json);
        return result;
      }
    } catch (error) {
      final result = AddFamiliModel(error: true, message: error.toString());
      return result;
    }
  }

  Future<UpdateFamiliModel> updateFamiliData(
    int idFamili,
    int idOrdo,
    String latinName,
    String commonName,
    String character,
    String description,
    XFile? image,
  ) async {
    try {
      final url = Uri.parse('$baseUrl/famili');
      var request = http.MultipartRequest('PUT', url);

      request.fields['id_famili'] = idFamili.toString();
      request.fields['id_ordo'] = idOrdo.toString();
      request.fields['nama_latin'] = latinName;
      request.fields['nama_umum'] = commonName;
      request.fields['ciri_ciri'] = character;
      request.fields['keterangan'] = description;

      if (image != null) {
        final imageFile = File(image.path);
        final imageField =
            await http.MultipartFile.fromPath('image', imageFile.path);
        request.files.add(imageField);
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      final json = jsonDecode(responseBody);

      if (response.statusCode == 200) {
        final result = UpdateFamiliModel.fromJson(json);
        return result;
      } else {
        final result = UpdateFamiliModel.fromJson(json);
        return result;
      }
    } catch (error) {
      final result = UpdateFamiliModel(error: true, message: error.toString());
      return result;
    }
  }
}
