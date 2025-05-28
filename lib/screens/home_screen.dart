import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/menu_card.dart';
import '../widgets/calendar_widget.dart';
import '../widgets/edukasi_slider.dart';
import 'profile_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = '';
  String userEmail = '';
  String userNohp = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadAllData();
  }

  // Ambil data user dari SharedPreferences
  Future<void> loadAllData() async {
    setState(() => isLoading = true);
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? '';
      userEmail = prefs.getString('userEmail') ?? '';
      userNohp = prefs.getString('userNohp') ?? '';
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final screenWidth = MediaQuery.of(context).size.width;
    // Batasi max width agar tidak terlalu lebar di desktop/proyektor
    final maxContentWidth = 500.0;

    return Scaffold(
      
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: loadAllData,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxContentWidth),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth > 600 ? 24 : 16, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header dengan nama user dan profile
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Halo, $userName',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'JiMun',
                                style: GoogleFonts.aclonica(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          // Avatar profile, klik untuk ke halaman ProfileScreen
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ProfileScreen(),
                                ),
                              );
                            },
                            child: const CircleAvatar(
                              radius: 22,
                              backgroundImage:
                                  AssetImage('assets/images/avatar.png'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 26),

                      // Menu Pendaftaran dan Antrian (pake Expanded biar responsif)
                      Row(
                        children: const [
                          Expanded(
                            child: MenuCard(
                              icon: Icons.assignment,
                              title: 'Pendaftaran',
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: MenuCard(
                              icon: Icons.people,
                              title: 'Antrian',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Kalender Imunisasi
                      const CalendarWidget(),
                      const SizedBox(height: 10),

                      const Text(
                        'Edukasi Kesehatan',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),

                      // Slider edukasi (akan otomatis responsif)
                      const EdukasiSlider(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
