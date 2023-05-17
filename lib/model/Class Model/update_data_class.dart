class UpdateDataClass {
  bool error;
  String message;

  UpdateDataClass({required this.error, required this.message});

  factory UpdateDataClass.fromJson(Map<String, dynamic> json) {
    return UpdateDataClass(
      error: json['error'] ?? false,
      message: json['message'] ?? '',
    );
  }
}
