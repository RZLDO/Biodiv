import 'dart:convert';
import 'dart:io';

import 'package:biodiv/model/get_ordo_model.dart';
import 'package:biodiv/model/ordo%20model/detail_ordo_model.dart';
import 'package:biodiv/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class OrdoRepository {
  Future<OrdoResponse> getOrdoData() async {
    try {
      final uri = Uri.parse('$baseUrl/ordo');
      http.Response response = await http.get(uri);
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final response = OrdoResponse.fromJson(json);
        return response;
      } else {
        final response = OrdoResponse.fromJson(json);
        return response;
      }
    } catch (error) {
      final response =
          OrdoResponse(error: true, message: error.toString(), data: []);
      return response;
    }
  }

  Future<DetailOrdoModel> getDetailOrdo(int idOrdo) async {
    try {
      final url = Uri.parse('$baseUrl/ordo/$idOrdo');

      http.Response response = await http.get(url);
      final json = jsonDecode(response.body);
      final result = DetailOrdoModel.fromJson(json);
      return result;
    } catch (error) {
      final result =
          DetailOrdoModel(error: true, message: error.toString(), data: null);

      return result;
    }
  }

  Future<AddOrdoData> addOrdoData(
    int idClass,
    String latinName,
    String commonName,
    String character,
    String description,
    XFile? image,
  ) async {
    try {
      final url = Uri.parse('$baseUrl/ordo');
      var request = http.MultipartRequest('POST', url);

      request.fields['nama_latin'] = latinName;
      request.fields['nama_umum'] = latinName;
      request.fields['ciri_ciri'] = latinName;
      request.fields['keterangan'] = latinName;
      request.fields['id_class'] = idClass.toString();

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
        print(json);
        final result = AddOrdoData.fromJson(json);
        return result;
      } else {
        final json = jsonDecode(responseBody);
        print(json);
        final result = AddOrdoData.fromJson(json);
        return result;
      }
    } catch (error) {
      final result = AddOrdoData(error: true, message: error.toString());
      return result;
    }
  }
}
