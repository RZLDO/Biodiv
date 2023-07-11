class GetScarcityModel {
  final bool error;
  final String message;
  final List<ConservationStatus> data;

  GetScarcityModel(
      {required this.error, required this.message, required this.data});

  factory GetScarcityModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> jsonData = json['data'];
    List<ConservationStatus> genusScarcityList = jsonData.map((item) {
      return ConservationStatus.fromJson(item);
    }).toList();
    return GetScarcityModel(
        error: json['error'],
        message: json['message'],
        data: genusScarcityList);
  }
}

class DetailScarcity {
  final bool error;
  final String message;
  final DetailScarcityData? data;

  DetailScarcity(
      {required this.error, required this.message, required this.data});

  factory DetailScarcity.fromJson(Map<String, dynamic> json) {
    return DetailScarcity(
        error: json['error'],
        message: json['message'],
        data: DetailScarcityData.fromJson(json['data']));
  }
}

class DetailScarcityData {
  final int idKategori;
  final String nama;
  final String umum;
  final String singkatan;
  final String keterangan;

  DetailScarcityData({
    required this.idKategori,
    required this.nama,
    required this.umum,
    required this.singkatan,
    required this.keterangan,
  });

  factory DetailScarcityData.fromJson(Map<String, dynamic> json) {
    return DetailScarcityData(
      idKategori: json['id_kategori'],
      nama: json['nama'],
      umum: json['umum'],
      singkatan: json['singkatan'],
      keterangan: json['keterangan'],
    );
  }
}

class ConservationStatus {
  int idKategori;
  String nama;
  String umum;
  String singkatan;
  String keterangan;

  ConservationStatus({
    required this.idKategori,
    required this.nama,
    required this.umum,
    required this.singkatan,
    required this.keterangan,
  });

  factory ConservationStatus.fromJson(Map<String, dynamic> json) {
    return ConservationStatus(
      idKategori: json['id_kategori'],
      nama: json['nama'],
      umum: json['umum'],
      singkatan: json['singkatan'],
      keterangan: json['keterangan'],
    );
  }
}

class ScarcityModelChart {
  final int idKelangkaan;
  final int count;
  ScarcityModelChart({required this.idKelangkaan, required this.count});
}

class ScarcityTotalModel {
  final bool error;
  final String message;
  final List<ScarcityDataModel> data;
  ScarcityTotalModel(
      {required this.error, required this.message, required this.data});
  factory ScarcityTotalModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> jsonData = json['data'];
    List<ScarcityDataModel> scarcityData = jsonData.map((item) {
      return ScarcityDataModel.fromJson(item);
    }).toList();
    return ScarcityTotalModel(
        error: json['error'], message: json['message'], data: scarcityData);
  }
}

class ScarcityDataModel {
  final int idKategori;
  final int count;
  ScarcityDataModel({required this.idKategori, required this.count});
  factory ScarcityDataModel.fromJson(Map<String, dynamic> json) {
    return ScarcityDataModel(
        idKategori: json['id_kategori'], count: json['count']);
  }
}
