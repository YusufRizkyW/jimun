import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'register_screen.dart';
import 'success_screen.dart';
import '../services/auth_service.dart'; // Pastikan Anda mengimpor AuthService
import '../screens/home_screen.dart'; // Pastikan Anda mengimpor HomeScreen jika diperlukan

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nohpController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Image.asset('assets/images/logo.png', width: 120, height: 120),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFF009688),
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Masuk",
                      style: GoogleFonts.aclonica(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 20),
                  TextField(
                    controller: nohpController,
                    decoration: inputDecoration("No. Telp", Icons.confirmation_number),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: inputDecoration("Password", Icons.lock_outline),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final result = await AuthService.login(
                            nohp: nohpController.text,
                            password: passwordController.text,
                          );
                          if (result['success']) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const HomeScreen()),
                            );
                            // TODO: Arahkan ke halaman utama/home setelah login sukses
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Login berhasil!')),
                            );
                            // Contoh: Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(result['message'] ?? 'Login gagal')),
                            );
                          }
                        },
                        style: buttonStyle(background: Colors.white, foreground: Colors.teal),
                        child: Text("Masuk", style: GoogleFonts.aclonica()),
                      ),
                      const SizedBox(width: 10),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen()));
                        },
                        style: buttonStyle(isOutlined: true),
                        child: Text("Registrasi", style: GoogleFonts.aclonica()),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration inputDecoration(String label, IconData icon) {
    return InputDecoration(
      prefixIcon: Icon(icon),
      labelText: label,
      labelStyle: GoogleFonts.aclonica(),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  ButtonStyle buttonStyle({Color background = Colors.white, Color foreground = Colors.teal, bool isOutlined = false}) {
    return isOutlined
        ? OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(color: Colors.white),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          )
        : ElevatedButton.styleFrom(
            backgroundColor: background,
            foregroundColor: foreground,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          );
  }
}
