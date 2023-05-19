class FamiliResponseModel {
  final bool error;
  final String message;
  final List<Family> data;
  FamiliResponseModel(
      {required this.error, required this.message, required this.data});

  factory FamiliResponseModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> jsonData = json['data'];
    List<Family> familiOrdoList = jsonData.map((item) {
      return Family.fromJson(item);
    }).toList();
    return FamiliResponseModel(
        error: json['error'], message: json['message'], data: familiOrdoList);
  }
}

class Family {
  final int id;
  final String latinName;
  final String commonName;
  final String characteristics;
  final String description;
  final String image;
  final int orderID;
  final String verification;

  Family({
    required this.id,
    required this.latinName,
    required this.commonName,
    required this.characteristics,
    required this.description,
    required this.image,
    required this.orderID,
    required this.verification,
  });

  factory Family.fromJson(Map<String, dynamic> json) {
    return Family(
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
