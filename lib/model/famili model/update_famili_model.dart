class UpdateFamiliModel {
  final bool error;
  final String message;

  UpdateFamiliModel({required this.error, required this.message});

  factory UpdateFamiliModel.fromJson(Map<String, dynamic> json) {
    return UpdateFamiliModel(error: json['error'], message: json['message']);
  }
}
