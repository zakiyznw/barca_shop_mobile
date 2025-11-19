import 'package:flutter/material.dart';
import 'package:barca_shop/screens/menu.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:barca_shop/screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
        title: 'Barca Shop',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
              .copyWith(secondary: Colors.blueAccent[400]),
        ),
        // home tetap LoginPage, tapi tambahkan named routes
        home: const LoginPage(),
        routes: {
          '/login': (context) => const LoginPage(),
          '/home': (context) => MyHomePage(),
        },
      ),
    );
  }
}
