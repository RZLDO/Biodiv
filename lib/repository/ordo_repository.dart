import 'dart:convert';

import 'package:biodiv/model/get_ordo_model.dart';
import 'package:biodiv/model/ordo%20model/detail_ordo_model.dart';
import 'package:biodiv/utils/constant.dart';
import 'package:http/http.dart' as http;

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
}
