class AddDataGenusModel {
  final bool error;
  final String message;

  AddDataGenusModel({required this.error, required this.message});

  factory AddDataGenusModel.fromJson(Map<String, dynamic> json) {
    return AddDataGenusModel(error: json['error'], message: json['message']);
  }
}
