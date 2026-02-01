import 'package:flutter/material.dart';
import 'package:project/pages/LoginPage.dart';

void main() {
  runApp(const WelcomePage());
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF3FAFF),
              Color(0xFFD7F1FF),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),

              // LET'S
              const Text(
                "LET'S",
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 2,
                  color: Colors.blueGrey,
                ),
              ),

              const SizedBox(height: 5),

              // EXPLORE
              const Text(
                "EXPLORE",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2F4F8F),
                ),
              ),

              const SizedBox(height: 5),

              // THE SRI LANKA
              const Text(
                "THE SRI LANKA",
                style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 1,
                  color: Colors.blueGrey,
                ),
              ),

              const SizedBox(height: 20),

              // Subtitle
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "Easy discovering new places and share these between your friends and travel together.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),

              const SizedBox(height: 35),

              // ENTER BUTTON
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6FA8FF),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  "ENTER",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
              ),

              const Spacer(),

              // Bottom Image
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Image.asset(
                  "assets/travel.png",
                  height: 450,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
