class SignInForm {
  String? username;
  String? email;
  String? password;

  SignInForm({
    this.username,
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() => {
        "username": username ?? "",
        "email": email,
        "password": password,
      };
}
