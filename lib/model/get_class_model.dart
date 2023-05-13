class GetDataClass {
  final bool error;
  final String message;
  final List<ClassData> data;

  GetDataClass({
    required this.error,
    required this.message,
    required this.data,
  });

  factory GetDataClass.fromJson(Map<String, dynamic> json) {
    final List<dynamic> jsonData = json['data'];
    List<ClassData> classDataList = jsonData.map((item) {
      return ClassData.fromJson(item);
    }).toList();

    return GetDataClass(
      error: json['error'],
      message: json['message'],
      data: classDataList,
    );
  }
}

class ClassData {
  final int idClass;
  final String namaLatin;
  final String namaUmum;
  final String ciriCiri;
  final String keterangan;
  final String gambar;
  final String verifikasi;

  ClassData({
    required this.idClass,
    required this.namaLatin,
    required this.namaUmum,
    required this.ciriCiri,
    required this.keterangan,
    required this.gambar,
    required this.verifikasi,
  });

  factory ClassData.fromJson(Map<String, dynamic> json) {
    return ClassData(
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
