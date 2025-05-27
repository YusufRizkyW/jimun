import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'screens/kalender_detail_screen.dart';
import 'auth/welcome_screen.dart';
import 'auth/login_screen.dart';
import 'auth/register_screen.dart';
import 'auth/success_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JiMun',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Sans',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const OnboardingScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/success': (context) => const SuccessScreen(),
        '/calendar': (context) => const KalenderDetailScreen(),
      },
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() => isLastPage = index == 2);
                },
                children: [
                  buildPage(
                    topText: "Selamat datang",
                    bottomText: "jiMun",
                    image: "assets/images/logo.png",
                    height: screenHeight,
                  ),
                  buildPage(
                    topText:
                        "Aplikasi yang dibuat dengan tujuan untuk mempermudah anda mengakses jadwal imunisasi, antrian online, dan edukasi yang bermanfaat.",
                    image: "assets/images/logo.png",
                    height: screenHeight,
                  ),
                  buildPage(
                    topText: "jiMun",
                    image: "assets/images/logo.png",
                    height: screenHeight,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    effect: const WormEffect(
                      activeDotColor: Colors.teal,
                      dotHeight: 8,
                      dotWidth: 8,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (isLastPage) {
                        Navigator.pushReplacementNamed(context, '/welcome');
                      } else {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      isLastPage ? "Mulai" : "Lanjut",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Widget halaman onboarding, font otomatis kecil jika teksnya panjang
  Widget buildPage({
    required String topText,
    required String image,
    required double height,
    String? bottomText,
  }) {
    // Deteksi jika teks panjang (banyak baris) → kecilkan font
    final bool isLongText = topText.contains('\n') || topText.length > 60;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            topText,
            textAlign: TextAlign.center,
            style: GoogleFonts.aclonica(
              fontSize: isLongText ? 17 : height * 0.022, // Kecilkan kalau teks panjang
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: height * 0.04),
          Image.asset(
            image,
            width: height * 0.25,
            height: height * 0.25,
            fit: BoxFit.contain,
          ),
          if (bottomText != null) ...[
            SizedBox(height: height * 0.04),
            Text(
              bottomText,
              textAlign: TextAlign.center,
              style: GoogleFonts.aclonica(
                fontSize: height * 0.028,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
