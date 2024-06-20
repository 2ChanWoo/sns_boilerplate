class Session {
  final String userToken;
  final String login;
  final String email;

  Session({
    required this.userToken,
    required this.login,
    required this.email,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      userToken: json['User-Token'] as String,
      login: json['login'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'User-Token': userToken,
      'login': login,
      'email': email,
    };
  }
}
