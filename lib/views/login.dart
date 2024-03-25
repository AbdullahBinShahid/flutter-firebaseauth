import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasewithflutter/views/home.dart';
import 'package:firebasewithflutter/views/signup.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  loginUser() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      print(credential);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeView()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(
            obscureText: false,
            controller: emailController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
            ),
          ),
          TextField(
            obscureText: false,
            controller: passwordController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {
              loginUser();
            },
            child: const Text("Login"),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignUpView()),
              );
            },
            child: const Text("Don't have an account? Register here.."),
          )
        ],
      ),
    );
  }
}
