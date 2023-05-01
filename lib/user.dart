class User {
  final String name;
  final bool isAdmin;
  final String email;

  User({required this.name, required this.email, this.isAdmin = false});
}
