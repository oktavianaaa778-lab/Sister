import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as location_pkg;
import 'widgets.dart';
import 'app_shell.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final nis = TextEditingController();
  final password = TextEditingController();
  @override
  void dispose() {
    nis.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: primary,
        body: SafeArea(
            child: Center(
                child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(children: [
            const SizedBox(height: 18),
            const PlaceholderImage('logo.png', height: 150, width: 200),
            const SizedBox(height: 18),
            const Text('BROTHER',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Poppins",
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1)),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(18)),
              child: Column(children: [
                loginField(
                    nis, 'Masukkan NIS atau Username', Icons.person_outline),
                const SizedBox(height: 12),
                loginField(password, 'Masukkan Password', Icons.lock_outline,
                    secret: true),
              ]),
            ),
            const SizedBox(height: 18),
            SizedBox(
                width: 220,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: darkBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14)),
                  onPressed: () => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const AppShell())),
                  child: const Text('Login',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                )),
            const SizedBox(height: 10),
          ]),
        ))),
      );
}

Widget loginField(TextEditingController c, String hint, IconData icon,
        {bool secret = false}) =>
    TextField(
      controller: c,
      obscureText: secret,
      decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: const Color(0xFFF4E9E9),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none)),
    );
