import 'dart:convert';

import 'package:biodiv/model/login_model.dart';
import 'package:http/http.dart' as http;

var _baseUrl = "http://192.168.31.86:5000/api";

class AuthRepository {
  var client = http.Client();
  Map header = {};
  Future<LoginResponse> login(String username, String password) async {
    try {
      var url = Uri.parse('$_baseUrl/login');
      http.Response response = await http
          .post(url, body: {'username': username, 'password': password});
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final loginResponse = LoginResponse.fromJson(json);
        return loginResponse;
      } else {
        final json = jsonDecode(response.body);
        final errorResponse = LoginResponse.fromJson(json);
        return errorResponse;
      }
    } catch (error) {
      final errorResponse = LoginResponse(
        error: "true",
        message: 'An error occurred: $error',
        loginResult: null,
      );
      return errorResponse;
    }
  }
}
