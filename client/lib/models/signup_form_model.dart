class SignUpForm {
  String? username;
  String? email;
  String? password;

  SignUpForm({
    this.username,
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
      };
}
