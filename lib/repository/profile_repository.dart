import 'dart:convert';

import 'package:biodiv/utils/constant.dart';

import '../model/profile model/profile.dart';
import 'package:http/http.dart' as http;

class ProfileRepository {
  Future<ProfileResponse> getDataFamili(int idUser) async {
    try {
      final url = Uri.parse('$baseUrl/profile/$idUser');
      http.Response response = await http.get(url);

      final json = jsonDecode(response.body);

      if (response.statusCode != 200) {
        final result = ProfileResponse.fromJson(json);
        return result;
      } else {
        final result = ProfileResponse.fromJson(json);
        return result;
      }
    } catch (error) {
      final result =
          ProfileResponse(error: true, message: error.toString(), data: null);
      return result;
    }
  }
}
