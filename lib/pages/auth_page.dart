import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/pages/menu.dart';
import 'package:untitled/pages/registration.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot) {
            if(snapshot.hasData) {
              return Menu();
            }
            else {
              return Reg();
            }
        },
      ),
    );
  }
}
