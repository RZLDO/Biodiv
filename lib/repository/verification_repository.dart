import 'dart:convert';

import 'package:biodiv/model/verif%20model/verif_model.dart';
import 'package:biodiv/utils/constant.dart';
import 'package:http/http.dart' as http;

class VerificationRepository {
  Future<VerifResponseModel> getTotalUnverifiedData() async {
    try {
      final url = Uri.parse('$baseUrl/unverified');
      http.Response response = await http.get(url);

      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final result = VerifResponseModel.fromJson(json);
        return result;
      } else {
        final result = VerifResponseModel.fromJson(json);
        return result;
      }
    } catch (error) {
      final result = VerifResponseModel(
          error: true, message: error.toString(), data: null);

      return result;
    }
  }
}
