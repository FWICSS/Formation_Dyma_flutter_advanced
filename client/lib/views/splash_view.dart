import 'package:client/views/home_view.dart';
import 'package:client/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    final bool? isLogggedin = Provider.of<AuthProvider>(context).isLoggedin;
    if (isLogggedin != null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (isLogggedin) {
          Navigator.pushReplacementNamed(context, ProfileView.routeName);
        } else {
          Navigator.pushReplacementNamed(context, HomeView.routeName);
        }
      });
    }

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Theme.of(context).primaryColor,
        child: Text(
          'Learn App',
          style: TextStyle(
            fontSize: 35,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
