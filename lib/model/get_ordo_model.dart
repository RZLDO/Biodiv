class OrdoResponse {
  bool error;
  final String message;
  final List<OrdoData> data;

  OrdoResponse({
    required this.error,
    required this.message,
    required this.data,
  });

  factory OrdoResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> jsonData = json['data'];
    List<OrdoData> ordoDataList = jsonData.map((item) {
      return OrdoData.fromJson(item);
    }).toList();

    return OrdoResponse(
      error: json['error'],
      message: json['message'],
      data: ordoDataList,
    );
  }
}

class OrdoData {
  final int idOrdo;
  final String namaLatin;
  final String namaUmum;
  final String ciriCiri;
  final String keterangan;
  final String gambar;
  final String verifikasi;

  OrdoData({
    required this.idOrdo,
    required this.namaLatin,
    required this.namaUmum,
    required this.ciriCiri,
    required this.keterangan,
    required this.gambar,
    required this.verifikasi,
  });

  factory OrdoData.fromJson(Map<String, dynamic> json) {
    return OrdoData(
      idOrdo: json['id_ordo'],
      namaLatin: json['nama_latin'],
      namaUmum: json['nama_umum'],
      ciriCiri: json['ciri_ciri'],
      keterangan: json['keterangan'],
      gambar: json['gambar'],
      verifikasi: json['verifikasi'],
    );
  }
}

class AddOrdoData {
  final bool error;
  final String message;
  AddOrdoData({required this.error, required this.message});

  factory AddOrdoData.fromJson(Map<String, dynamic> json) {
    return AddOrdoData(error: json['error'], message: json['message']);
  }
}

class DeleteOrdoModel {
  final bool error;
  final String message;
  DeleteOrdoModel({required this.error, required this.message});

  factory DeleteOrdoModel.fromJson(Map<String, dynamic> json) {
    return DeleteOrdoModel(error: json['error'], message: json['message']);
  }
}
