class DeleteFamiliModel {
  final bool error;
  final String message;

  DeleteFamiliModel({required this.error, required this.message});

  factory DeleteFamiliModel.fromJson(Map<String, dynamic> json) {
    return DeleteFamiliModel(error: json['error'], message: json['message']);
  }
}
