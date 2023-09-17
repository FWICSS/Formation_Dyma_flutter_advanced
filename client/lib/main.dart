import 'package:client/providers/auth_provider.dart';
import 'package:client/providers/user_provider.dart';
import 'package:client/views/auth/signin_view.dart';
import 'package:client/views/auth/signup_view.dart';
import 'package:client/views/home_view.dart';
import 'package:client/views/not_found_view.dart';
import 'package:client/views/profile_view.dart';
import 'package:client/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyAuth());
}

class MyAuth extends StatefulWidget {
  const MyAuth({super.key});

  @override
  State<MyAuth> createState() => _MyAuthState();
}

class _MyAuthState extends State<MyAuth> {
  final AuthProvider authProvider = AuthProvider();

  @override
  void initState() {
    authProvider.initAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authProvider),
        ChangeNotifierProxyProvider<AuthProvider, UserProvider>(
            create: (_) => UserProvider(),
            update: (_, authProvider, oldUserProvider) =>
                oldUserProvider!..update(authProvider)),
      ],
      child: MaterialApp(
          title: 'My Auth',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
          ),
          home: const SplashView(),
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case ProfileView.routeName:
                return MaterialPageRoute(
                  builder: (_) => const ProfileView(),
                );
              case HomeView.routeName:
                return MaterialPageRoute(
                  builder: (_) => const HomeView(),
                );
              case SignInView.routeName:
                return MaterialPageRoute(
                  builder: (_) => const SignInView(),
                );
              case SignUpView.routeName:
                return MaterialPageRoute(
                  builder: (_) => const SignUpView(),
                );
              default:
                return null;
            }
          },
          onUnknownRoute: (_) => MaterialPageRoute(
                builder: (_) => const NotFoundView(),
              )),
    );
  }
}
