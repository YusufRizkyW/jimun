import 'package:flutter/material.dart';
import 'package:jimun/auth/login_screen.dart';
import '../services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  final String name;
  final String email;
  final String nohp;

  const ProfileScreen({
    super.key,
    required this.name,
    required this.email,
    required this.nohp,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7EDF9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF009688),
        leading: const BackButton(color: Colors.white),
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                       backgroundColor: Colors.teal.shade100, 
      backgroundImage: const AssetImage('assets/images/avatar.png'), 
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(widget.email),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 30),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Tentang saya',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                ),
                const SizedBox(height: 20),
                fieldStatic(label: 'Email', value: widget.email),
                const SizedBox(height: 10),
                fieldStatic(label: 'No. Telp', value: widget.nohp),
                const SizedBox(height: 10),
                // TextField(
                //   obscureText: _obscurePassword,
                //   decoration: InputDecoration(
                //     labelText: 'Password',
                //     suffixIcon: IconButton(
                //       icon: Icon(_obscurePassword
                //           ? Icons.visibility_off
                //           : Icons.visibility),
                //       onPressed: () {
                //         setState(() {
                //           _obscurePassword = !_obscurePassword;
                //         });
                //       },
                //     ),
                //     border: const UnderlineInputBorder(),
                //   ),
                // ),
                const SizedBox(height: 20),
                Opacity(
                  opacity: 0.2,
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 150,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'JiMun',
                  style: GoogleFonts.aclonica(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  final token = prefs.getString('token');
                  if (token != null) {
                    await AuthService.logout(token: token);
                    await prefs.remove('token');
                  }
                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                      (route) => false,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget fieldStatic({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label :', style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        TextFormField(
          initialValue: value,
          readOnly: true,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
