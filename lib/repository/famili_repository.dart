import 'dart:convert';

import 'package:biodiv/model/famili%20model/delete_famili.dart';
import 'package:biodiv/model/famili%20model/detai_famili_mode.dart';
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
        return result;
      } else {
        final result = FamiliResponseModel.fromJson(json);
        return result;
      }
    } catch (error) {
      final result =
          FamiliResponseModel(error: true, message: error.toString(), data: []);
      return result;
    }
  }

  Future<FamiliDetailModel> getDetailFamiliData(int idFamili) async {
    try {
      final url = Uri.parse('$baseUrl/famili/$idFamili');
      http.Response response = await http.get(url);

      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final result = FamiliDetailModel.fromJson(json);
        return result;
      }
      {
        final result = FamiliDetailModel.fromJson(json);
        return result;
      }
    } catch (error) {
      final result =
          FamiliDetailModel(error: true, message: error.toString(), data: null);
      return result;
    }
  }

  Future<DeleteFamiliModel> deletFamili(int idFamili) async {
    try {
      final url = Uri.parse('$baseUrl/famili/$idFamili');
      http.Response response = await http.delete(url);
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final result = DeleteFamiliModel.fromJson(json);
        return result;
      } else {
        final result = DeleteFamiliModel.fromJson(json);
        return result;
      }
    } catch (error) {
      final result = DeleteFamiliModel(error: true, message: error.toString());

      return result;
    }
  }
}
