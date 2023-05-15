class LoginResponse {
  final bool error;
  final String message;
  LoginResult? loginResult;

  LoginResponse({
    required this.error,
    required this.message,
    this.loginResult,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      error: json['error'] ?? true,
      message: json['message'] ?? "",
      loginResult: json.containsKey('loginResult')
          ? LoginResult.fromJson(json['loginResult'])
          : null,
    );
  }
}

class LoginResult {
  final int userId;
  final String username;
  final int userLevel;
  final String token;

  LoginResult(
      {required this.userId,
      required this.username,
      required this.userLevel,
      required this.token});

  factory LoginResult.fromJson(Map<String, dynamic> json) {
    return LoginResult(
      userId: json['userId'] ?? 0,
      username: json['username'] ?? "",
      userLevel: json['userLevel'] ?? 3,
      token: json['token'] ?? "",
    );
  }
}
