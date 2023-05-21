import 'dart:convert';

import 'package:biodiv/model/genus/get_data_genus.dart';
import 'package:biodiv/utils/constant.dart';
import 'package:http/http.dart' as http;

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
}
