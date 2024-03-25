import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasewithflutter/views/login.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  registerUser() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
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
              registerUser();
            },
            child: const Text("Register"),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginView()),
              );
            },
            child: const Text("Already have an account? login here.."),
          )
        ],
      ),
    );
  }
}
