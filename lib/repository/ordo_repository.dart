import 'dart:convert';

import 'package:biodiv/model/get_ordo_model.dart';
import 'package:biodiv/utils/constant.dart';
import 'package:http/http.dart' as http;

class OrdoRepository {
  Future<OrdoResponse> getOrdoData() async {
    try {
      final uri = Uri.parse('$baseUrl/ordo');
      http.Response response = await http.get(uri);
      final json = jsonDecode(response.body);
      print(json);
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
}
