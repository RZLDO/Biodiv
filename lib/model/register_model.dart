class RegisterResponse {
  bool? error;
  String? message;
  RegisterResponse({this.error, this.message});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(error: json['error'], message: json['message']);
  }
}
