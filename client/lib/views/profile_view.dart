import 'package:client/providers/auth_provider.dart';
import 'package:client/providers/user_provider.dart';
import 'package:client/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
          reverse: true,
          children: [
            ListTile(
              tileColor: Theme.of(context).primaryColor,
              title: Text(
                'Déconnexion',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Provider.of<AuthProvider>(context, listen: false).signout();
                Navigator.pushNamed(context, HomeView.routeName);
              },
            )
          ],
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Center(
          child: user != null
              ? Text(
                  user.username ?? user.email,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : CircularProgressIndicator(),
        ),
      ),
    );
  }
}
