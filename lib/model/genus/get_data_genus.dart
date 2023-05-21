class GetDetailGenusModel {
  final bool error;
  final String message;
  final GenusData? data;

  GetDetailGenusModel(
      {required this.error, required this.message, required this.data});

  factory GetDetailGenusModel.fromJson(Map<String, dynamic> json) {
    return GetDetailGenusModel(
        error: json['error'],
        message: json['message'],
        data: GenusData.fromJson(json['data']));
  }
}

class GetGenusModel {
  final bool error;
  final String message;
  final List<GenusData> data;

  GetGenusModel(
      {required this.error, required this.message, required this.data});

  factory GetGenusModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> jsonData = json['data'];
    List<GenusData> genusOrdoList = jsonData.map((item) {
      return GenusData.fromJson(item);
    }).toList();
    return GetGenusModel(
        error: json['error'], message: json['message'], data: genusOrdoList);
  }
}

class GenusData {
  final int idGenus;
  final String namaLatin;
  final String namaUmum;
  final String ciriCiri;
  final String keterangan;
  final String gambar;
  final int idFamili;
  final String verifikasi;

  GenusData({
    required this.idGenus,
    required this.namaLatin,
    required this.namaUmum,
    required this.ciriCiri,
    required this.keterangan,
    required this.gambar,
    required this.idFamili,
    required this.verifikasi,
  });

  factory GenusData.fromJson(Map<String, dynamic> json) {
    return GenusData(
      idGenus: json['id_genus'],
      namaLatin: json['nama_latin'],
      namaUmum: json['nama_umum'],
      ciriCiri: json['ciri_ciri'],
      keterangan: json['keterangan'],
      gambar: json['gambar'],
      idFamili: json['id_famili'],
      verifikasi: json['verifikasi'],
    );
  }
}
