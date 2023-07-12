import 'package:biodiv/model/Class%20Model/get_class_model.dart';
import 'package:biodiv/model/genus/get_data_genus.dart';
import 'package:biodiv/model/get_ordo_model.dart';
import 'package:biodiv/model/spesies/get_spesies_data.dart';

import '../famili model/famili_model.dart';

class SearchingModel {
  final bool error;
  final String message;
  final SearchResult? data;

  SearchingModel({
    required this.error,
    required this.message,
    required this.data,
  });

  factory SearchingModel.fromJson(Map<String, dynamic> json) {
    return SearchingModel(
      error: json['error'],
      message: json['message'],
      data: SearchResult.fromJson(json['data']),
    );
  }
}

class SearchResult {
  final List<ClassData> dataClass;
  final List<OrdoData> dataOrdo;
  final List<Family> dataFamili;
  final List<GenusData> dataGenus;
  final List<SpeciesData> dataSpesies;

  SearchResult(
      {required this.dataClass,
      required this.dataOrdo,
      required this.dataFamili,
      required this.dataGenus,
      required this.dataSpesies});

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    final List<dynamic> classData = json['class'];
    final List<dynamic> ordoData = json['ordo'];
    final List<dynamic> familiData = json['famili'];
    final List<dynamic> genusData = json['genus'];
    final List<dynamic> spesiesData = json['spesies'];
    List<ClassData> listClass = classData.map((item) {
      return ClassData.fromJson(item);
    }).toList();
    List<OrdoData> listOrdo = ordoData.map((item) {
      return OrdoData.fromJson(item);
    }).toList();
    List<Family> listFamili = familiData.map((item) {
      return Family.fromJson(item);
    }).toList();
    List<GenusData> listGenus = genusData.map((item) {
      return GenusData.fromJson(item);
    }).toList();
    List<SpeciesData> listSpesies = spesiesData.map((item) {
      return SpeciesData.fromJson(item);
    }).toList();

    return SearchResult(
        dataClass: listClass,
        dataOrdo: listOrdo,
        dataFamili: listFamili,
        dataGenus: listGenus,
        dataSpesies: listSpesies);
  }
}
