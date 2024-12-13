class User {
  final String id;
  final String name;
  final String email;
  final String? password;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.password,
  });

  // تحويل JSON إلى كائن User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }

  // تحويل كائن User إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
