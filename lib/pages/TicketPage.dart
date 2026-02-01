import 'package:flutter/material.dart';

class TicketPage extends StatelessWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tickets"),
        backgroundColor: Colors.blueAccent,
      ),
      body: const Center(
        child: Text("Your booked tickets will appear here."),
      ),
    );
  }
}
