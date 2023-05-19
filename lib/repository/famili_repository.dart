import 'dart:convert';

import 'package:biodiv/model/famili%20model/famili_model.dart';
import 'package:biodiv/utils/constant.dart';
import 'package:http/http.dart' as http;

class FamiliRepository {
  Future<FamiliResponseModel> getFamiliData() async {
    try {
      final url = Uri.parse('$baseUrl/famili');
      http.Response response = await http.get(url);

      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final result = FamiliResponseModel.fromJson(json);
        print(result.message);
        return result;
      } else {
        final result = FamiliResponseModel.fromJson(json);
        print(result.message);
        return result;
      }
    } catch (error) {
      final result =
          FamiliResponseModel(error: true, message: error.toString(), data: []);
      print(result.message);
      return result;
    }
  }
}
