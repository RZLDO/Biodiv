import 'dart:convert';

import 'package:biodiv/model/Class%20Model/get_class_model.dart';
import 'package:biodiv/model/get_ordo_model.dart';
import 'package:biodiv/model/verif%20model/verif_model.dart';
import 'package:biodiv/utils/constant.dart';
import 'package:http/http.dart' as http;

import '../model/famili model/famili_model.dart';
import '../model/genus/get_data_genus.dart';
import '../model/spesies/get_spesies_data.dart';
import '../model/verif model/verif_success.dart';

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

  Future<GetDataClass> getClassUnverified() async {
    try {
      final url = Uri.parse('$baseUrl/unverified/class');
      http.Response response = await http.get(url);
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final result = GetDataClass.fromJson(json);
        return result;
      } else {
        final result = GetDataClass.fromJson(json);
        return result;
      }
    } catch (error) {
      final result =
          GetDataClass(error: true, message: error.toString(), data: []);
      return result;
    }
  }

  Future<GetGenusModel> getGenusUnverified() async {
    try {
      final url = Uri.parse('$baseUrl/unverified/genus');
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

  Future<OrdoResponse> getOrdoUnverified() async {
    try {
      final url = Uri.parse('$baseUrl/unverified/ordo');
      http.Response response = await http.get(url);
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final result = OrdoResponse.fromJson(json);
        return result;
      } else {
        final result = OrdoResponse.fromJson(json);
        return result;
      }
    } catch (error) {
      final result =
          OrdoResponse(error: true, message: error.toString(), data: []);
      return result;
    }
  }

  Future<FamiliResponseModel> getFamiliUnverified() async {
    try {
      final url = Uri.parse('$baseUrl/unverified/famili');
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

  Future<SpesiesGetAllModel> getSpesiesUnverified() async {
    try {
      final url = Uri.parse('$baseUrl/unverified/spesies');
      http.Response response = await http.get(url);
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final result = SpesiesGetAllModel.fromJson(json);
        return result;
      } else {
        final result = SpesiesGetAllModel.fromJson(json);
        return result;
      }
    } catch (error) {
      final result =
          SpesiesGetAllModel(error: true, message: error.toString(), data: []);
      return result;
    }
  }

  Future<VerifModel> verifClass(int id, String path) async {
    try {
      final url = Uri.parse('$baseUrl/verif/$path/$id');

      http.Response response = await http.put(url);
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final result = VerifModel.fromJson(json);
        return result;
      } else {
        final result = VerifModel.fromJson(json);
        return result;
      }
    } catch (error) {
      final result = VerifModel(error: true, message: error.toString());
      return result;
    }
  }

  Future<VerifModel> deleteUnverifClass(int id, String path) async {
    try {
      final url = Uri.parse('$baseUrl/$path/$id');

      http.Response response = await http.delete(url);
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final result = VerifModel.fromJson(json);
        return result;
      } else {
        final result = VerifModel.fromJson(json);
        return result;
      }
    } catch (error) {
      final result = VerifModel(error: true, message: error.toString());
      return result;
    }
  }
}
