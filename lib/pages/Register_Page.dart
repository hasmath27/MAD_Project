import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const RegisterPage(),
    );
  }
}

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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

            // Full Name Input
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Full Name",
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
                    suffixIcon: const Icon(Icons.person, color: Colors.blue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Email Input
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Email",
                    style: TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "example@gmail.com",
                    filled: true,
                    fillColor: Colors.grey[50],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    suffixIcon: const Icon(Icons.email, color: Colors.blue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Password Input
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Password",
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
            const SizedBox(height: 20),

            // Confirm Password Input
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Confirm Password",
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
            const SizedBox(height: 20),

            // Register Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text(
                  "Register",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Sign In Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? ",
                    style:
                        TextStyle(color: Color.fromARGB(255, 128, 127, 127))),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // back to login page
                  },
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
