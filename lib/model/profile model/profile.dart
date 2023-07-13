class ProfileResponse {
  final bool error;
  final String message;
  final ProfileData? data;
  ProfileResponse(
      {required this.error, required this.message, required this.data});

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
        error: json['error'],
        message: json['message'],
        data: ProfileData.fromJson(json['data']));
  }
}

class ProfileData {
  int idInstitusi;
  String nama;
  String alamat;
  String username;
  String password;
  int idLevel;
  ProfileData(
      {required this.idInstitusi,
      required this.nama,
      required this.alamat,
      required this.username,
      required this.password,
      required this.idLevel});

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
        idInstitusi: json['id_institusi'],
        nama: json['nama'],
        alamat: json['alamat'],
        username: json['username'],
        password: json['password'],
        idLevel: json['id_level']);
  }
}
