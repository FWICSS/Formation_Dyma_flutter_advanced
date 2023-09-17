import 'package:client/models/signup_form_model.dart';
import 'package:client/providers/auth_provider.dart';
import 'package:client/views/auth/signin_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  static const routeName = '/signup';

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late SignUpForm signUpForm;
  late TextEditingController _email;
  late TextEditingController _password;
  late TextEditingController _username;
  bool _isObscure = true;

  @override
  void initState() {
    signUpForm = SignUpForm();
    _email = TextEditingController(text: signUpForm.email);
    _password = TextEditingController(text: signUpForm.password);
    _username = TextEditingController(text: signUpForm.username);
    super.initState();
  }

  FormState get form => _formKey.currentState!;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _username.dispose();
    super.dispose();
  }

  Future<void> SubmitForm() async {
    if (form.validate()) {
      form.save();
      final error = await Provider.of<AuthProvider>(context, listen: false)
          .signup(signUpForm);
      print("s'incrit");
      if (error != null) {
        print(error);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
            backgroundColor: Colors.red,
          ),
        );
      } else if (error == null) {
        Navigator.pushNamed(context, SignInView.routeName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,
                color: Theme.of(context).primaryColor),
            onPressed: () => Navigator.pop(context),
          )),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Inscription',
              style: TextStyle(
                fontSize: 35,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 15)),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                    ),
                    child: Lottie.asset(
                      'assets/lotties/animation_lmcfp5gh.json',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context)
                            .primaryColor, // Couleur de la bordure
                        width: 2.0, // Largeur de la bordure
                      ),
                      borderRadius: BorderRadius.circular(
                          20), // Optionnel : pour les coins arrondis
                    ),
                    padding: EdgeInsets.only(left: 5, right: 5, top: 10),
                    child: TextField(
                      controller: _email,
                      cursorColor: Colors.grey,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        prefixIconColor: Theme.of(context).primaryColor,
                        labelText: "Email",
                        labelStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).primaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        signUpForm.email = value;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context)
                            .primaryColor, // Couleur de la bordure
                        width: 2.0, // Largeur de la bordure
                      ),
                      borderRadius: BorderRadius.circular(
                          20), // Optionnel : pour les coins arrondis
                    ),
                    padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
                    child: TextField(
                      controller: _username,
                      cursorColor: Colors.grey,
                      style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.account_circle_outlined),
                        prefixIconColor: Theme.of(context).primaryColor,
                        labelText: "Username",
                        labelStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).primaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        signUpForm.username = value;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context)
                            .primaryColor, // Couleur de la bordure
                        width: 2.0, // Largeur de la bordure
                      ),
                      borderRadius: BorderRadius.circular(
                          20), // Optionnel : pour les coins arrondis
                    ),
                    padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
                    child: TextField(
                      controller: _password,
                      cursorColor: Colors.grey,
                      obscureText: _isObscure,
                      style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.password_outlined),
                        prefixIconColor: Theme.of(context).primaryColor,
                        labelText: "Password",
                        labelStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).primaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                        suffixIconColor: Theme.of(context).primaryColor,
                      ),
                      onChanged: (value) {
                        signUpForm.password = value;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          maximumSize: Size(200, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          fixedSize: Size(
                              0.40 * MediaQuery.of(context).size.width, 50),
                        ),
                        onPressed: SubmitForm,
                        child: const Text(
                          'S\‘inscrire',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
