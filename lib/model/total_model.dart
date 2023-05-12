class TotalDataResponse {
  bool error;
  String message;
  TotalData? data;

  TotalDataResponse({
    required this.error,
    required this.message,
    required this.data,
  });

  factory TotalDataResponse.fromJson(Map<String, dynamic> json) {
    return TotalDataResponse(
      error: json['error'],
      message: json['message'],
      data: TotalData.fromJson(json['data']),
    );
  }
}

class TotalData {
  int classCount;
  int familiCount;
  int genusCount;
  int ordoCount;
  int spesiesCount;
  int totalDataCount;

  TotalData({
    required this.classCount,
    required this.familiCount,
    required this.genusCount,
    required this.ordoCount,
    required this.spesiesCount,
    required this.totalDataCount,
  });

  factory TotalData.fromJson(Map<String, dynamic> json) {
    return TotalData(
      classCount: json['class'],
      familiCount: json['famili'],
      genusCount: json['genus'],
      ordoCount: json['ordo'],
      spesiesCount: json['spesies'],
      totalDataCount: json['totalData'],
    );
  }
}
