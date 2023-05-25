class VerifModel {
  final bool error;
  final String message;

  VerifModel({required this.error, required this.message});

  factory VerifModel.fromJson(Map<String, dynamic> json) {
    return VerifModel(error: json['error'], message: json['message']);
  }
}
