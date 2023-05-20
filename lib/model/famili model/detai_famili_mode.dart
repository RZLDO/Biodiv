class FamiliDetailModel {
  final bool error;
  final String message;
  final FamilyDetail? data;

  FamiliDetailModel(
      {required this.error, required this.message, required this.data});

  factory FamiliDetailModel.fromJson(Map<String, dynamic> json) {
    return FamiliDetailModel(
        error: json['error'],
        message: json['message'],
        data: FamilyDetail.fromJson(json['data']));
  }
}

class FamilyDetail {
  final int idFamili;
  final String latinName;
  final String commonName;
  final String characteristics;
  final String description;
  final String image;
  final int idOrdo;
  final String verification;

  FamilyDetail({
    required this.idFamili,
    required this.latinName,
    required this.commonName,
    required this.characteristics,
    required this.description,
    required this.image,
    required this.idOrdo,
    required this.verification,
  });

  factory FamilyDetail.fromJson(Map<String, dynamic> json) {
    return FamilyDetail(
      idFamili: json['id_famili'],
      latinName: json['nama_latin'],
      commonName: json['nama_umum'],
      characteristics: json['ciri_ciri'],
      description: json['keterangan'],
      image: json['gambar'],
      idOrdo: json['id_ordo'],
      verification: json['verifikasi'],
    );
  }
}
