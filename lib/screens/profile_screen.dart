import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7EDF9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF009688),
        leading: const BackButton(color: Colors.white),
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.black12,
                  child: Icon(Icons.person, size: 30),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Aisyah Nur Aini',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('aicalala@email.com'),
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
            fieldStatic(label: 'Email', value: 'aicalala@email.com'),
            const SizedBox(height: 10),
            fieldStatic(label: 'No. Telp', value: '085712346789'),
            const SizedBox(height: 10),
            TextField(
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                border: const UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 40),
            Opacity(
              opacity: 0.2,
              child: Image.asset(
                'assets/images/logo.png',
                height: 100,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'JiMun',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Sans'),
            ),
          ],
        ),
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
