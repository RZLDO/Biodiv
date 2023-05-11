import 'dart:convert';

import 'package:biodiv/model/login_model.dart';
import 'package:biodiv/model/register_model.dart';
import 'package:http/http.dart' as http;

var _baseUrl = "http://192.168.43.225:5000/api";

class AuthRepository {
  var client = http.Client();
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
        error: true,
        message: 'An error occurred: $error',
        loginResult: null,
      );
      return errorResponse;
    }
  }

  Future<RegisterResponse> register(
      String name, String address, String username, String password) async {
    try {
      final url = Uri.parse('$_baseUrl/register');
      http.Response response = await http.post(url, body: {
        'name': name,
        'address': address,
        'username': username,
        'password': password,
        'userLevel': "3",
      });
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final registerResponse = RegisterResponse.fromJson(json);
        return registerResponse;
      } else {
        final json = jsonDecode(response.body);
        final errorResponse = RegisterResponse.fromJson(json);
        return errorResponse;
      }
    } catch (error) {
      final errorResponse = RegisterResponse(
        error: true,
        message: 'An error occurred: $error',
      );
      return errorResponse;
    }
  }
}
