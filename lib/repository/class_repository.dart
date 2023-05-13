import 'dart:convert';

import 'package:biodiv/model/get_class_model.dart';
import 'package:biodiv/utils/constant.dart';
import 'package:http/http.dart' as http;

class ClassRepository {
  Future<GetDataClass> getDataClass() async {
    try {
      final url = Uri.parse('${baseUrl}class');
      http.Response response = await http.get(url);
      final json = jsonDecode(response.body);
      print(json);
      if (response.statusCode == 200) {
        final dataClass = GetDataClass.fromJson(json);
        return dataClass;
      } else {
        final dataClass = GetDataClass.fromJson(json);
        return dataClass;
      }
    } catch (error) {
      print("catch error : " + error.toString());
      final errorResponse =
          GetDataClass(error: true, message: error.toString(), data: null);
      return errorResponse;
    }
  }
}
