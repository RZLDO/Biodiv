class DetailResponse {
  final bool error;
  final String message;
  final ClassDataDetail? data;

  DetailResponse({
    required this.error,
    required this.message,
    required this.data,
  });

  factory DetailResponse.fromJson(Map<String, dynamic> json) {
    return DetailResponse(
      error: json['error'],
      message: json['message'],
      data: ClassDataDetail.fromJson(json['data']),
    );
  }
}

class ClassDataDetail {
  final int idClass;
  final String namaLatin;
  final String namaUmum;
  final String ciriCiri;
  final String keterangan;
  final String gambar;
  final String verifikasi;

  ClassDataDetail({
    required this.idClass,
    required this.namaLatin,
    required this.namaUmum,
    required this.ciriCiri,
    required this.keterangan,
    required this.gambar,
    required this.verifikasi,
  });

  factory ClassDataDetail.fromJson(Map<String, dynamic> json) {
    return ClassDataDetail(
      idClass: json['id_class'],
      namaLatin: json['nama_latin'],
      namaUmum: json['nama_umum'],
      ciriCiri: json['ciri_ciri'],
      keterangan: json['keterangan'],
      gambar: json['gambar'],
      verifikasi: json['verifikasi'],
    );
  }
}
