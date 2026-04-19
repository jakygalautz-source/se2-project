class SettingsModel {
  final String username;
  final String email;
  final String password;

  SettingsModel({
    required this.username,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {'username': username, 'email': email, 'password': password};
  }

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      password:
          '', // Weil man ein bestehendes Passwort normalerweise nicht einfach zurücklädt und ins Feld schreibt.
    );
  }
}
