import 'dart:convert';
import 'dart:io';

import 'package:biodiv/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../model/spesies/get_spesies_data.dart';
import 'package:http/http.dart' as http;

class SpesiesRepository {
  Future<AddLocation> addSpesiesLocation(String locationName, double latitude,
      double longitude, int radius, int idSpesies) async {
    try {
      final url = Uri.parse('$baseUrl/spesies/location/');
      Map<String, dynamic> requestBody = {
        "nama_lokasi": locationName,
        "latitude": latitude,
        "longitude": longitude,
        "radius": radius,
        "idSpesies": idSpesies
      };
      final headers = <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      };
      http.Response response =
          await http.post(url, body: jsonEncode(requestBody), headers: headers);

      final json = jsonDecode(response.body);
      print(json);
      final result = AddLocation.fromJson(json);
      return result;
    } catch (error) {
      final result = AddLocation(error: true, message: error.toString());
      return result;
    }
  }

  Future<SpesiesGetAllModel> getSpesiesByScarcity(int idScarcity) async {
    try {
      final url = Uri.parse('$baseUrl/spesies/scarcity/$idScarcity');

      http.Response response = await http.get(url);
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final result = SpesiesGetAllModel.fromJson(json);
        return result;
      } else {
        final result = SpesiesGetAllModel.fromJson(json);
        return result;
      }
    } catch (error) {
      final result =
          SpesiesGetAllModel(error: true, message: error.toString(), data: []);
      return result;
    }
  }

  Future<SpesiesGetAllModel> getSpesiesByGenus(int idGenus, int? page) async {
    try {
      final url = page == 0
          ? Uri.parse('$baseUrl/spesies/genus/?id_genus=$idGenus')
          : Uri.parse('$baseUrl/spesies/genus/?id_genus=$idGenus&page=$page');
      http.Response response = await http.get(url);
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final result = SpesiesGetAllModel.fromJson(json);
        return result;
      } else {
        final result = SpesiesGetAllModel.fromJson(json);
        return result;
      }
    } catch (error) {
      final result =
          SpesiesGetAllModel(error: true, message: error.toString(), data: []);
      return result;
    }
  }

  Future<SpeciesDetailModel> getDetailSpesies(int idSpesies) async {
    try {
      final url = Uri.parse('$baseUrl/spesies/$idSpesies');
      http.Response response = await http.get(url);

      final json = jsonDecode(response.body);
      final result = SpeciesDetailModel.fromJson(json);
      return result;
    } catch (error) {
      final result = SpeciesDetailModel(
          error: true, message: error.toString(), data: null, lokasi: []);
      return result;
    }
  }

  Future<SpesiesGetAllModel> spesiesGetAll() async {
    try {
      final url = Uri.parse('$baseUrl/spesies');
      http.Response response = await http.get(url);
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final result = SpesiesGetAllModel.fromJson(json);
        return result;
      } else {
        final result = SpesiesGetAllModel.fromJson(json);
        return result;
      }
    } catch (error) {
      final result =
          SpesiesGetAllModel(error: true, message: error.toString(), data: []);
      return result;
    }
  }

  Future<AddData> addOrdoData(
    int idGenus,
    int idCategory,
    String latinName,
    String commonName,
    String habitat,
    String status,
    String character,
    String description,
    XFile? image,
  ) async {
    try {
      final url = Uri.parse('$baseUrl/spesies');
      var request = http.MultipartRequest('POST', url);

      request.fields['nama_latin'] = latinName;
      request.fields['nama_umum'] = commonName;
      request.fields['habitat'] = habitat;
      request.fields['status'] = status;
      request.fields['karakteristik'] = character;
      request.fields['keterangan'] = description;
      request.fields['id_genus'] = idGenus.toString();
      request.fields['id_kategori'] = idCategory.toString();

      if (image != null) {
        var imagefile = File(image.path);

        var imageField =
            await http.MultipartFile.fromPath('image', imagefile.path);
        request.files.add(imageField);
      }

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        final json = jsonDecode(responseBody);
        final result = AddData.fromJson(json);
        return result;
      } else {
        final json = jsonDecode(responseBody);
        final result = AddData.fromJson(json);
        return result;
      }
    } catch (error) {
      final result = AddData(error: true, message: error.toString());
      return result;
    }
  }

  Future<AddData> updataeSpesiesData(
    int idGenus,
    int idCategory,
    String latinName,
    String commonName,
    String habitat,
    String status,
    String character,
    String description,
    XFile? image,
    int idSpesies,
  ) async {
    try {
      final url = Uri.parse('$baseUrl/spesies/$idSpesies');
      var request = http.MultipartRequest('PUT', url);

      request.fields['nama_latin'] = latinName;
      request.fields['nama_umum'] = commonName;
      request.fields['habitat'] = habitat;
      request.fields['status'] = status;
      request.fields['karakteristik'] = character;
      request.fields['keterangan'] = description;
      request.fields['id_spesies'] = idSpesies.toString();
      request.fields['id_genus'] = idGenus.toString();
      request.fields['id_kategori'] = idCategory.toString();

      if (image != null) {
        var imagefile = File(image.path);

        var imageField =
            await http.MultipartFile.fromPath('image', imagefile.path);
        request.files.add(imageField);
      }

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        final json = jsonDecode(responseBody);
        final result = AddData.fromJson(json);
        return result;
      } else {
        final json = jsonDecode(responseBody);
        final result = AddData.fromJson(json);
        return result;
      }
    } catch (error) {
      final result = AddData(error: true, message: error.toString());
      return result;
    }
  }

  Future<DeleteDataSpesies> deleteDataSpesies(int idSpesies) async {
    try {
      final uri = Uri.parse('$baseUrl/spesies/$idSpesies');
      http.Response response = await http.delete(uri);
      final json = jsonDecode(response.body);
      final result = DeleteDataSpesies.fromJson(json);
      return result;
    } catch (error) {
      final result = DeleteDataSpesies(error: true, message: error.toString());
      return result;
    }
  }
}
