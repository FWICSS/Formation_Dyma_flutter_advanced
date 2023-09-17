import 'package:client/views/auth/signin_view.dart';
import 'package:flutter/material.dart';

import 'auth/signup_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Bienvenue sur Dyma !',
              style: TextStyle(
                fontSize: 35,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 0.40 * MediaQuery.of(context).size.width > 400
                      ? 200
                      : 0.40 * MediaQuery.of(context).size.width,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey.shade900,
                    ),
                    onPressed: () => Navigator.pushNamed(
                      context,
                      SignUpView.routeName,
                    ),
                    child: const Text(
                      'S\' inscrire',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  width: 0.40 * MediaQuery.of(context).size.width > 400
                      ? 200
                      : 0.40 * MediaQuery.of(context).size.width,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    onPressed: () => Navigator.pushNamed(
                      context,
                      SignInView.routeName,
                    ),
                    child: const Text(
                      'Connexion',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
