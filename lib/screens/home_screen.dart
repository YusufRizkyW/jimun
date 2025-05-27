import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/menu_card.dart';
import '../widgets/calendar_widget.dart';
import '../widgets/edukasi_slider.dart';
import 'profile_screen.dart';

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

  // Fungsi utama untuk refresh semua data
  Future<void> loadAllData() async {
    setState(() {
      isLoading = true;
    });
    await Future.wait([
      loadUser(),
      // loadCalendar(), // Tambahkan fungsi lain jika ada
    ]);
    setState(() {
      isLoading = false;
    });
  }

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('userName') ?? '';
    userEmail = prefs.getString('userEmail') ?? '';
    userNohp = prefs.getString('userNohp') ?? '';
  }

  // Contoh fungsi load data kalender (jika ada)
  // Future<void> loadCalendar() async {
  //   calendarEvents = await CalendarService.fetchEvents();
  // }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: loadAllData, // Ganti jadi loadAllData
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
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
                          Text(
                            'Halo, $userName',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                            MaterialPageRoute(
                              builder: (_) => ProfileScreen(),
                            ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Expanded(
                        child: MenuCard(
                          icon: Icons.assignment,
                          title: 'Pendaftaran',
                        ),
                      ),
                      SizedBox(width: 16),
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
                  const CalendarWidget(), // Ganti jika ingin passing data kalender dari state
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
      ),
    );
  }
}
