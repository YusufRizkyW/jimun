import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Sudah punya akun?",
              style: GoogleFonts.aclonica(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
              child: Text("Masuk", style: GoogleFonts.aclonica()),
            ),
            const SizedBox(height: 20),
            Text(
              "Belum punya akun?",
              style: GoogleFonts.aclonica(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RegisterScreen()),
                );
              },
              child: Text("Registrasi", style: GoogleFonts.aclonica()),
            ),
          ],
        ),
      ),
    );
  }
}
