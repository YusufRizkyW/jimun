import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'success_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final numberController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

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
                  Text("Registrasi",
                      style: GoogleFonts.aclonica(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 20),
                  TextField(controller: numberController, decoration: inputDecoration("Number", Icons.confirmation_number)),
                  const SizedBox(height: 10),
                  TextField(controller: emailController, decoration: inputDecoration("Email (Opsional)", Icons.email_outlined)),
                  const SizedBox(height: 10),
                  TextField(controller: passwordController, obscureText: true, decoration: inputDecoration("Password", Icons.lock_outline)),
                  const SizedBox(height: 10),
                  TextField(controller: confirmPasswordController, obscureText: true, decoration: inputDecoration("Confirm Password", Icons.lock)),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: buttonStyle(isOutlined: true),
                        child: Text("Masuk", style: GoogleFonts.aclonica()),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const SuccessScreen()));
                        },
                        style: buttonStyle(),
                        child: Text("Registrasi", style: GoogleFonts.aclonica()),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
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

  ButtonStyle buttonStyle({bool isOutlined = false}) {
    return isOutlined
        ? OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(color: Colors.white),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          )
        : ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.teal,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          );
  }
}
