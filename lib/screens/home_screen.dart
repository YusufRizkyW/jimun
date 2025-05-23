import 'package:flutter/material.dart';
import '../widgets/menu_card.dart';
import '../widgets/calendar_widget.dart';
import '../widgets/edukasi_slider.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  // final String userName;

  const HomeScreen({super.key});

  // const HomeScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text('Halo, $userName',
                        //     style: const TextStyle(
                        //       fontSize: 18,
                        //       fontWeight: FontWeight.bold,
                        //     )),
                        Text('Halo, JiMun',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        const Text(
                          'JiMun',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ProfileScreen()),
                        );
                      },
                      child: const CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage('assets/images/avatar.png'),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                
                // Menu
                // Menu
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Expanded(
                      child: MenuCard(
                        icon: Icons.assignment,
                        title: 'Pendaftaran',
                      ),
                    ),
                    SizedBox(width: 16), // Jarak antar kartu
                    Expanded(
                      child: MenuCard(
                        icon: Icons.people,
                        title: 'Antrian',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),
                
                // Kalender
                const CalendarWidget(),
                const SizedBox(height: 16),

                const Text(
                  'Edukasi Kesehatan',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                const EdukasiSlider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
