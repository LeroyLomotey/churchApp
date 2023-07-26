class AppUser {
  String name;
  String uid;
  bool isAdmin;
  bool guest;
  String email;

  AppUser(
      {this.uid = '',
      this.name = "Guest",
      this.guest = true,
      this.email = 'Guest',
      this.isAdmin = false});

  updateUser({required uid, name, email, isAdmin}) {
    this.uid = uid;
    this.name = name;
    this.email = email;
    this.isAdmin = isAdmin;
    guest = false;
  }

  reset() {
    name = "Guest";
    guest = true;
    email = 'Guest';
    isAdmin = false;
  }
}
