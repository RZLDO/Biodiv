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
  final int id;
  final String latinName;
  final String commonName;
  final String characteristics;
  final String description;
  final String image;
  final int orderID;
  final String verification;

  FamilyDetail({
    required this.id,
    required this.latinName,
    required this.commonName,
    required this.characteristics,
    required this.description,
    required this.image,
    required this.orderID,
    required this.verification,
  });

  factory FamilyDetail.fromJson(Map<String, dynamic> json) {
    return FamilyDetail(
      id: json['id_famili'],
      latinName: json['nama_latin'],
      commonName: json['nama_umum'],
      characteristics: json['ciri_ciri'],
      description: json['keterangan'],
      image: json['gambar'],
      orderID: json['id_ordo'],
      verification: json['verifikasi'],
    );
  }
}
