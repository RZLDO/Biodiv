class AddFamiliModel {
  final bool error;
  final String message;

  AddFamiliModel({required this.error, required this.message});

  factory AddFamiliModel.fromJson(Map<String, dynamic> json) {
    return AddFamiliModel(error: json['error'], message: json['message']);
  }
}
