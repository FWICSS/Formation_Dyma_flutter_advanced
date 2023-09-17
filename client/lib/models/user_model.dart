class User {
  String? id;
  String email;
  String username;

  User({required this.email, this.id, required this.username});

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'],
        username = json['username'] ?? "";
}
