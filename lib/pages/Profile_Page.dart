import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  final Map<String, String> user = const {
    'name': 'Tetteh Jeron Asiedu',
    'email': 'jeron@example.com',
    'image': 'assets/user.png',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text("Profile", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 1. CENTERED AVATAR
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.blueAccent.withValues(alpha:0.1),
                backgroundImage: AssetImage(user['image']!), 
                // Fallback icon if image is missing
                //child: const Icon(Icons.person, size: 60, color: Colors.blueAccent),
              ),
            ),
            const SizedBox(height: 25),

            // 2. INFO CARD
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha:0.05), blurRadius: 10)
                ],
              ),
              child: Column(
                children: [
                  _buildProfileRow(Icons.person_outline, "Name", user['name']!),
                  const Divider(height: 30),
                  _buildProfileRow(Icons.email_outlined, "Email", user['email']!),
                ],
              ),
            ),
            const Spacer(),

            // 3. LOGOUT BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Logout clicked")),
                  );
                },
                icon: const Icon(Icons.logout_rounded),
                label: const Text("Logout", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.blueAccent),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}