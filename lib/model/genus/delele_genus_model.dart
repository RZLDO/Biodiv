class DeleteGenusModel {
  final bool error;
  final String message;

  DeleteGenusModel({required this.error, required this.message});

  factory DeleteGenusModel.fromJson(Map<String, dynamic> json) {
    return DeleteGenusModel(error: json['error'], message: json['message']);
  }
}
