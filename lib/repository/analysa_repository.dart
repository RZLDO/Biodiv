import 'dart:convert';

import 'package:biodiv/model/analysa%20model/analysa_model.dart';
import 'package:biodiv/utils/constant.dart';
import 'package:http/http.dart' as http;

class AnalysaRepository {
  Future<AnalysaResultModel> getAnalysaData(int idSpesies) async {
    try {
      final url = Uri.parse('$baseUrl/analysis/$idSpesies');
      http.Response response = await http.get(url);
      final json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final result = AnalysaResultModel.fromJson(json);
        return result;
      } else {
        final result = AnalysaResultModel.fromJson(json);
        return result;
      }
    } catch (error) {
      final result = AnalysaResultModel(
          error: true, message: error.toString(), result: []);
      return result;
    }
  }
}
