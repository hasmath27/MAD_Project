import 'package:flutter/material.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookmarks"),
        backgroundColor: Colors.blueAccent,
      ),
      body: const Center(
        child: Text("Your bookmarked places will appear here."),
      ),
    );
  }
}
