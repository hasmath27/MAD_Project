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
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // Location Icon
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue.withAlpha(25),
                    shape: BoxShape.circle,
                  ),
                ),
                const Icon(Icons.location_on,
                    size: 80, color: Colors.blueAccent),
              ],
            ),
            const SizedBox(height: 10),

            // App Name & Subtitle
            const Text(
              "Ceylon Explorer",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
                fontFamily: 'cursive',
              ),
            ),
            const Text(
              "EXPLORE THE SRI LANKA",
              style: TextStyle(
                  letterSpacing: 2, fontSize: 12, color: Colors.blueGrey),
            ),
            const SizedBox(height: 40),

            // User Name Input
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Enter your User Name",
                    style: TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Ranuja Liyanaarachchi",
                    filled: true,
                    fillColor: Colors.grey[50],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    suffixIcon:
                        const Icon(Icons.check_circle, color: Colors.blue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Password Input
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Enter your password",
                    style: TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "***************",
                    filled: true,
                    fillColor: Colors.grey[50],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    suffixIcon:
                        const Icon(Icons.visibility_off, color: Colors.blue),
                  ),
                ),
              ],
            ),

            // Forgot Password
            const Align(
              alignment: Alignment.centerRight,
              child:
                  TextButton(onPressed: null, child: Text("Forgot password?")),
            ),

            // Sign In Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text(
                  "Sign In",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Sign Up Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account? ",
                    style:
                        TextStyle(color: Color.fromARGB(255, 128, 127, 127))),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()),
                    );
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text("or", style: TextStyle(color: Colors.grey)),
            ),

            // Google Button
            SizedBox(
              width: double.infinity,
              height: 60,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon:
                    const Icon(Icons.g_mobiledata, color: Colors.red, size: 40),
                label: const Text(
                  "Continue with Google",
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.grey),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Facebook Button
            SizedBox(
              width: double.infinity,
              height: 60,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.facebook, color: Colors.blue, size: 30),
                label: const Text(
                  " Continue with Facebook",
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.grey),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Guest Text
          ],
        ),
      ),
    );
  }
}
