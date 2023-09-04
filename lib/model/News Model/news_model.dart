class GetNewsModel {
  bool error;
  String message;
  List<NewsResult> newsResult;
  GetNewsModel(
      {required this.error, required this.message, required this.newsResult});

  factory GetNewsModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> jsonData = json['result'];
    List<NewsResult> newsData = jsonData.map((item) {
      return NewsResult.fromJson(item);
    }).toList();
    return GetNewsModel(
        error: json['error'], message: json['message'], newsResult: newsData);
  }
}

class NewsResult {
  int idBerita;
  String judulBerita;
  String deskripsi;
  String webUrl;
  String image;

  NewsResult(
      {required this.idBerita,
      required this.judulBerita,
      required this.deskripsi,
      required this.webUrl,
      required this.image});
  factory NewsResult.fromJson(Map<String, dynamic> json) {
    return NewsResult(
        idBerita: json['id_berita'],
        judulBerita: json['judul_berita'],
        deskripsi: json['deskripsi_singkat'],
        webUrl: json['web_url'],
        image: json['gambar']);
  }
}

class BaseNewsResult {
  final bool error;
  final String message;

  BaseNewsResult({required this.error, required this.message});

  factory BaseNewsResult.fromJson(Map<String, dynamic> json) {
    return BaseNewsResult(error: json['error'], message: json['message']);
  }
}
