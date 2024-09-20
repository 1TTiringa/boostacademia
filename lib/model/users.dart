class User {
  final int? id;
  final String name;
  final String email;
  final String password;

  User(
      {this.id,
      required this.name,
      required this.email,
      required this.password,});
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password
    };
  }

  @override
  String toString() {
    return 'User{ID: $id, email: $email, name: $name, password: $password}';
  }
}