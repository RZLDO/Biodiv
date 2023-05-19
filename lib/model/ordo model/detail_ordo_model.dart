class DetailOrdoModel {
  final bool error;
  final String message;
  final OrdoModel? data;

  DetailOrdoModel({
    required this.error,
    required this.message,
    required this.data,
  });

  factory DetailOrdoModel.fromJson(Map<String, dynamic> json) {
    return DetailOrdoModel(
      error: json['error'],
      message: json['message'],
      data: OrdoModel.fromJson(json['data']),
    );
  }
}

class OrdoModel {
  int idOrdo;
  String namaLatin;
  String namaUmum;
  String ciriCiri;
  String keterangan;
  String gambar;
  int idClass;
  String verifikasi;

  OrdoModel({
    required this.idOrdo,
    required this.namaLatin,
    required this.namaUmum,
    required this.ciriCiri,
    required this.keterangan,
    required this.gambar,
    required this.idClass,
    required this.verifikasi,
  });

  factory OrdoModel.fromJson(Map<String, dynamic> json) {
    return OrdoModel(
      idOrdo: json['id_ordo'],
      namaLatin: json['nama_latin'],
      namaUmum: json['nama_umum'],
      ciriCiri: json['ciri_ciri'],
      keterangan: json['keterangan'],
      gambar: json['gambar'],
      idClass: json['id_class'],
      verifikasi: json['verifikasi'],
    );
  }
}

class UpdateOrdoModel {
  final bool error;
  final String message;

  UpdateOrdoModel({required this.error, required this.message});

  factory UpdateOrdoModel.fromJson(Map<String, dynamic> json) {
    return UpdateOrdoModel(error: json['error'], message: json['message']);
  }
}
