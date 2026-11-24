import 'package:flutter/material.dart';
import 'login.dart';

void main() => runApp(const PresensiApp());

const Color primary = Color(0xFF5B91C6);
const Color darkBlue = Color(0xFF294866);
const Color lightBlue = Color(0xFFE5F1FB);
const Color background = Color(0xFFF4F7FA);
const Color ink = Color(0xFF263746);

class PresensiApp extends StatelessWidget {
  const PresensiApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'BROTHER',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: background,
          colorScheme: ColorScheme.fromSeed(seedColor: primary),
          appBarTheme: const AppBarTheme(
              backgroundColor: primary,
              foregroundColor: Colors.white,
              elevation: 0),
        ),
        home: const LoginScreen(),
      );
}
