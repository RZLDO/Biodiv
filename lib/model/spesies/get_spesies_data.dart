class SpeciesDetailModel {
  final bool error;
  final String message;
  final Species? data;

  SpeciesDetailModel(
      {required this.error, required this.message, required this.data});

  factory SpeciesDetailModel.fromJson(Map<String, dynamic> json) {
    return SpeciesDetailModel(
        error: json['error'],
        message: json['message'],
        data: Species.fromJson(json['data']));
  }
}

class Species {
  final int id;
  final String latinName;
  final String commonName;
  final String habitat;
  final String characteristics;
  final String description;
  final String status;
  final String image;

  Species({
    required this.id,
    required this.latinName,
    required this.commonName,
    required this.habitat,
    required this.characteristics,
    required this.description,
    required this.status,
    required this.image,
  });

  factory Species.fromJson(Map<String, dynamic> json) {
    return Species(
      id: json['id_spesies'],
      latinName: json['nama_latin'],
      commonName: json['nama_umum'],
      habitat: json['habitat'],
      characteristics: json['karakteristik'],
      description: json['keterangan'],
      status: json['status'],
      image: json['gambar'],
    );
  }

  get namaLatin => null;
}

class AddData {
  final bool error;
  final String message;

  AddData({required this.error, required this.message});

  factory AddData.fromJson(Map<String, dynamic> json) {
    return AddData(error: json['error'], message: json['message']);
  }
}

class DeleteDataSpesies {
  final bool error;
  final String message;

  DeleteDataSpesies({required this.error, required this.message});

  factory DeleteDataSpesies.fromJson(Map<String, dynamic> json) {
    return DeleteDataSpesies(error: json['error'], message: json['message']);
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
