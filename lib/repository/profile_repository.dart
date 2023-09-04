import 'dart:convert';

import 'package:biodiv/utils/constant.dart';

import '../model/profile model/profile.dart';
import 'package:http/http.dart' as http;

class ProfileRepository {
  get iduser => null;

  Future<ProfileResponse> getDataFamili(
    int idUser,
  ) async {
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

  Future<ChangePasswordAndUsernameResponse> changeUsernameRepository(
      int idUser, String username) async {
    try {
      final uri = Uri.parse('$baseUrl/username/$iduser');
      http.Response response =
          await http.put(uri, body: {"newUsername": username});
      final json = jsonDecode(response.body);
      final result = ChangePasswordAndUsernameResponse.fromJson(json);
      return result;
    } catch (error) {
      final result = ChangePasswordAndUsernameResponse(
          error: true, message: error.toString());
      return result;
    }
  }

  Future<ChangePasswordAndUsernameResponse> changePasswordRepository(
      int idUser, String oldPassword, String newPassword) async {
    try {
      final uri = Uri.parse('$baseUrl/users/password/$idUser');
      http.Response response = await http.put(uri,
          body: {'oldPassword': oldPassword, 'newPassword': newPassword});
      final json = jsonDecode(response.body);
      final result = ChangePasswordAndUsernameResponse.fromJson(json);
      return result;
    } catch (error) {
      final result = ChangePasswordAndUsernameResponse(
          error: true, message: error.toString());
      return result;
    }
  }
}
