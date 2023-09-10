class AnalysaResultModel {
  final bool error;
  final String message;
  final List<AnalysisData> result;

  AnalysaResultModel({
    required this.error,
    required this.message,
    required this.result,
  });

  factory AnalysaResultModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> resultData = json['result'] as List<dynamic>;
    List<AnalysisData> analysisDataList =
        resultData.map((data) => AnalysisData.fromJson(data)).toList();

    return AnalysaResultModel(
      error: json['error'] as bool,
      message: json['message'] as String,
      result: analysisDataList,
    );
  }
}

class AnalysisData {
  final String bulan;
  final int totalPerkemunculan;
  final String namaLokasi;

  AnalysisData(
      {required this.bulan,
      required this.totalPerkemunculan,
      required this.namaLokasi});

  factory AnalysisData.fromJson(Map<String, dynamic> json) {
    return AnalysisData(
      bulan: json['bulan'],
      totalPerkemunculan: json['total_perkemunculan'],
      namaLokasi: json['nama_lokasi'] as String,
    );
  }
}
