import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/kalender_detail_screen.dart';
import 'auth/welcome_screen.dart';
import 'auth/login_screen.dart';
import 'auth/register_screen.dart';
import 'auth/success_screen.dart';
import 'screens/home_screen.dart';

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
        '/': (context) => const EntryScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/splash': (context) => const SplashScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/success': (context) => const SuccessScreen(),
        '/calendar': (context) => const KalenderDetailScreen(),
      },
    );
  }
}

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});
  @override
  State<EntryScreen> createState() => _EntryScreenState();
}
class _EntryScreenState extends State<EntryScreen> {
  @override
  void initState() { super.initState(); checkOnboarding(); }
  Future<void> checkOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    final alreadyOnboard = prefs.getBool('alreadyOnboard') ?? false;
    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;
    if (alreadyOnboard) {
      Navigator.pushReplacementNamed(context, '/splash');
    } else {
      Navigator.pushReplacementNamed(context, '/onboarding');
    }
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

// ONBOARDING
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
                    context: context,
                    topText: "Selamat datang",
                    bottomText: "jiMun",
                    image: "assets/images/logo.png",
                    height: screenHeight,
                  ),
                  buildPage(
                    context: context,
                    topText:
                        "Aplikasi yang dibuat dengan tujuan untuk mempermudah anda mengakses jadwal imunisasi, antrian online, dan edukasi yang bermanfaat.",
                    image: "assets/images/logo.png",
                    height: screenHeight,
                  ),
                  buildPage(
                    context: context,
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
                    onPressed: () async {
                      if (isLastPage) {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('alreadyOnboard', true);
                        Navigator.pushReplacementNamed(context, '/splash');
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

  // FINAL: BuildPage dengan fontSize adaptif dan kecil
  Widget buildPage({
    required BuildContext context,
    required String topText,
    required String image,
    required double height,
    String? bottomText,
  }) {
    final bool isLongText = topText.length > 65 || topText.split('\n').length > 2;
    // Ukuran tetap supaya ga pernah kegedean
    double fontSize = isLongText ? 15.0 : 19.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            topText,
            textAlign: TextAlign.center,
            style: GoogleFonts.aclonica(
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: height * 0.04),
          Image.asset(
            image,
            width: height * 0.23,
            height: height * 0.23,
            fit: BoxFit.contain,
          ),
          if (bottomText != null) ...[
            SizedBox(height: height * 0.03),
            Text(
              bottomText,
              textAlign: TextAlign.center,
              style: GoogleFonts.aclonica(
                fontSize: 21.0,
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

// SplashScreen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLogin();
  }
  Future<void> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    if (token != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      );
    } else {
      Navigator.pushReplacementNamed(context, '/welcome');
    }
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
