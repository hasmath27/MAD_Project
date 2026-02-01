import 'package:flutter/material.dart';

class TouristPlaceDetailsPage extends StatelessWidget {
  final String placeName;

  const TouristPlaceDetailsPage({super.key, required this.placeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(placeName),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.orangeAccent.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Center(child: Text("Tourist Image Placeholder")),
            ),
            const SizedBox(height: 20),
            Text(
              placeName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Description of the tourist place, tips, entry fees, timings, and other important info.",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
