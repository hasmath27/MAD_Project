import 'package:flutter/material.dart';

class NearbyPlacesPage extends StatelessWidget {
  const NearbyPlacesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nearby Places"),
        backgroundColor: Colors.purpleAccent,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(14),
        itemCount: 10, // example count
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Container(
                width: 60,
                height: 60,
                color: Colors.purpleAccent.withOpacity(0.2),
                child: const Icon(Icons.place, size: 40),
              ),
              title: Text("Nearby Place ${index + 1}"),
              subtitle: const Text("Distance and description here."),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
