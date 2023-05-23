class VerifResponseModel {
  final bool error;
  final String message;
  final Data? data;

  VerifResponseModel(
      {required this.error, required this.message, required this.data});

  factory VerifResponseModel.fromJson(Map<String, dynamic> json) {
    return VerifResponseModel(
      error: json['error'],
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  int classCount;
  int familyCount;
  int genusCount;
  int ordoCount;
  int speciesCount;
  int totalData;

  Data({
    required this.classCount,
    required this.familyCount,
    required this.genusCount,
    required this.ordoCount,
    required this.speciesCount,
    required this.totalData,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      classCount: json['class'],
      familyCount: json['famili'],
      genusCount: json['genus'],
      ordoCount: json['ordo'],
      speciesCount: json['spesies'],
      totalData: json['totalData'],
    );
  }
}
