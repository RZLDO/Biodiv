class AddData {
  final bool error;
  final String message;

  AddData({required this.error, required this.message});

  factory AddData.fromJson(Map<String, dynamic> json) {
    return AddData(error: json['error'], message: json['message']);
  }
}

class SpesiesGetAllModel {
  final bool error;
  final String message;
  final List<SpeciesData> data;

  SpesiesGetAllModel(
      {required this.error, required this.message, required this.data});

  factory SpesiesGetAllModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> jsonData = json['data'];
    List<SpeciesData> speciesDataList = jsonData.map((item) {
      return SpeciesData.fromJson(item);
    }).toList();
    return SpesiesGetAllModel(
        error: json['error'], message: json['message'], data: speciesDataList);
  }
}

class SpeciesData {
  final int idSpesies;
  final String namaLatin;
  final String namaUmum;
  final String habitat;
  final String karakteristik;
  final String keterangan;
  final String status;
  final String gambar;
  final int idGenus;
  final int idKategori;
  final String verifikasi;

  SpeciesData({
    required this.idSpesies,
    required this.namaLatin,
    required this.namaUmum,
    required this.habitat,
    required this.karakteristik,
    required this.keterangan,
    required this.status,
    required this.gambar,
    required this.idGenus,
    required this.idKategori,
    required this.verifikasi,
  });

  factory SpeciesData.fromJson(Map<String, dynamic> json) {
    return SpeciesData(
      idSpesies: json['id_spesies'],
      namaLatin: json['nama_latin'],
      namaUmum: json['nama_umum'],
      habitat: json['habitat'],
      karakteristik: json['karakteristik'],
      keterangan: json['keterangan'],
      status: json['status'],
      gambar: json['gambar'],
      idGenus: json['id_genus'],
      idKategori: json['id_kategori'],
      verifikasi: json['verifikasi'],
    );
  }
}
