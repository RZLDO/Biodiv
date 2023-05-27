import 'dart:convert';

import 'package:biodiv/model/scarcity/scarcity.dart';
import 'package:biodiv/utils/constant.dart';

import 'package:http/http.dart' as http;

class ScarcityRepository {
  Future<GetScarcityModel> getScarcity() async {
    try {
      final url = Uri.parse('$baseUrl/scarcity');
      http.Response response = await http.get(url);

      final json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final result = GetScarcityModel.fromJson(json);
        return result;
      } else {
        final result = GetScarcityModel.fromJson(json);
        return result;
      }
    } catch (error) {
      final result =
          GetScarcityModel(error: true, message: error.toString(), data: []);
      return result;
    }
  }

  Future<ScarcityTotalModel> getTotalScarcity() async {
    try {
      final url = Uri.parse('$baseUrl/scarcity/total');

      http.Response response = await http.get(url);

      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final result = ScarcityTotalModel.fromJson(json);
        return result;
      } else {
        final result = ScarcityTotalModel.fromJson(json);
        return result;
      }
    } catch (error) {
      final result =
          ScarcityTotalModel(error: true, message: error.toString(), data: []);
      return result;
    }
  }
}
