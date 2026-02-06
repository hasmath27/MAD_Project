import 'package:flutter/material.dart';
import 'package:project/pages/HomePage.dart';
import 'package:project/pages/Register_Page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFDFF),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),

            // Modern Location Icon with Soft Shadow
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withValues(alpha:0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.withValues(alpha:0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const Icon(
                    Icons.location_on_rounded,
                    size: 70,
                    color: Colors.blueAccent,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // App Name & Subtitle
            const Text(
              "Ceylon Explorer",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A237E),
                letterSpacing: -0.5,
              ),
            ),
            Text(
              "EXPLORE THE SRI LANKA",
              style: TextStyle(
                letterSpacing: 3,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.withValues(alpha:0.6),
              ),
            ),
            const SizedBox(height: 50),

            // User Name Input
            _buildCustomTextField(
              label: "User Name",
              hint: "Ranuja Liyanaarachchi",
              icon: Icons.check_circle_outline,
              isPassword: false,
            ),
            const SizedBox(height: 20),

            // Password Input
            _buildCustomTextField(
              label: "Password",
              hint: "••••••••••••",
              icon: Icons.visibility_off_outlined,
              isPassword: true,
            ),

            const SizedBox(height: 10),

            // Sign In Button
            Container(
              width: double.infinity,
              height: 58,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withValues(alpha:0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Sign In",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Divider
            Row(
              children: [
                Expanded(child: Divider(color: Colors.grey.withValues(alpha:0.3))),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text("or", style: TextStyle(color: Colors.grey)),
                ),
                Expanded(child: Divider(color: Colors.grey.withValues(alpha:0.3))),
              ],
            ),
            const SizedBox(height: 30),

            // Sign Up Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account? ",
                  style: TextStyle(color: Colors.blueGrey),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterPage()),
                    );
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper for consistent TextFields
  Widget _buildCustomTextField({
    required String label,
    required String hint,
    required IconData icon,
    required bool isPassword,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A237E),
            ),
          ),
          ),
          TextField(
            obscureText: isPassword,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.withValues(alpha:0.6)),
              filled: true,
              fillColor: Colors.white,
              suffixIcon: Icon(icon, color: Colors.blueAccent, size: 22),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.blueAccent.withValues(alpha:0.1)),
              )
            )
          )
        ]
      );     
  }
}