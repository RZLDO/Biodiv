import 'dart:convert';

import 'package:biodiv/model/search%20model/search_model.dart';
import 'package:biodiv/utils/constant.dart';
import 'package:http/http.dart' as http;

class SearchingRepository {
  Future<SearchingModel> getSearchingData(String query) async {
    try {
      var url = Uri.parse('$baseUrl/search/$query');
      http.Response response = await http.get(url);
      final json = jsonDecode(response.body);
      if (response.statusCode != 200) {
        final result = SearchingModel.fromJson(json);
        return result;
      } else {
        final result = SearchingModel.fromJson(json);
        return result;
      }
    } catch (error) {
      final result =
          SearchingModel(error: true, message: error.toString(), data: null);
      return result;
    }
  }
}
