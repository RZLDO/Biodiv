import 'dart:convert';

import 'package:biodiv/model/genus/delele_genus_model.dart';
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
}
