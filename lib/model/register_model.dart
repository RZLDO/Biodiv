class RegisterResponse {
  bool error;
  String message;
  RegisterResponse({required this.error, required this.message});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
        error: json['error'] ?? true, message: json['message'] ?? "");
  }
}
