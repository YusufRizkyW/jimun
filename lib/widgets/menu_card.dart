import 'package:flutter/material.dart';
import 'package:jimun/screens/pendaftaran_screen.dart';
import 'package:jimun/screens/antrian_screen.dart';

class MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;

  const MenuCard({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (title == 'Pendaftaran') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PendaftaranScreen()),
          );
        }
        else if (title == 'Antrian') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AntrianScreen()),
          );
        }
        // Tambahkan else if jika ada menu lain dengan navigasi
      },
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              color: Colors.grey.shade200,
              offset: const Offset(2, 2),
            )
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 40, color: Colors.teal),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}