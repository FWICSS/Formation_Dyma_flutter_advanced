import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../models/signin_form_model.dart';
import '../../models/user_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/user_provider.dart';
import '../profile_view.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  static const routeName = '/signin';

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late SignInForm signInForm;
  late TextEditingController _email;
  late TextEditingController _password;
  bool _isObscure = true;
  String? error;

  @override
  void initState() {
    signInForm = SignInForm();
    _email = TextEditingController(text: signInForm.email);
    _password = TextEditingController(text: signInForm.password);
    super.initState();
  }

  FormState get form => _formKey.currentState!;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> SubmitForm() async {
    if (form.validate()) {
      form.save();

      final response = await Provider.of<AuthProvider>(context, listen: false)
          .signin(signInForm);

      if (response is User) {
        Provider.of<UserProvider>(context, listen: false).updateUser(response);
        Navigator.pushNamed(context, ProfileView.routeName);
      }
      if (response is! User) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              response['error'],
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            backgroundColor: Colors.red,
          ),
        );
        // setState(() {
        //   error = response['error'];
        // });
      }
    }
    // if (!form.validate()) print("form not validate");
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
              'Connexion',
              style: TextStyle(
                fontSize: 35,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
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
                      'assets/lotties/animation_lmdxjixb.json',
                      repeat: false,
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
                      controller: _email,
                      cursorColor: Colors.grey,
                      style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email_outlined),
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
                        signInForm.email = value;
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
                      ),
                      onChanged: (value) {
                        signInForm.password = value;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 10),
                  //   child: error != null
                  //       ? Text(
                  //           error!,
                  //           style: const TextStyle(
                  //             color: Colors.red,
                  //           ),
                  //         )
                  //       : null,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          maximumSize: const Size(200, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          fixedSize: Size(
                              0.40 * MediaQuery.of(context).size.width, 50),
                        ),
                        onPressed: SubmitForm,
                        child: const Text(
                          'Se connecter',
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
