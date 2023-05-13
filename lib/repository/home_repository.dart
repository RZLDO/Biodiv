import 'dart:convert';

import 'package:biodiv/model/total_model.dart';
import 'package:biodiv/utils/constant.dart';
import 'package:http/http.dart' as http;

class HomeRepository {
  Future<TotalDataResponse> getTotalData() async {
    try {
      var url = Uri.parse('$baseUrl/totalData');
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final data = TotalDataResponse.fromJson(json);
        return data;
      } else {
        final json = jsonDecode(response.body);
        final data = TotalDataResponse.fromJson(json);
        return data;
      }
    } catch (error) {
      print("catch error : " + error.toString());
      final errorResponse =
          TotalDataResponse(error: true, message: error.toString(), data: null);
      return errorResponse;
    }
  }
}
