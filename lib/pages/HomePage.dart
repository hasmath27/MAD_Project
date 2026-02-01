// HomePage.dart
import 'package:flutter/material.dart';
import 'LocationDetails_Page.dart';
import 'TouristPlaceDetails_Page.dart';
import 'Recommendation_Page.dart';
import 'NearbyPlaces_Page.dart';
import 'Bookmark_Page.dart';
import 'TicketPage.dart';
import 'Profile_Page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Pages for BottomNavigationBar
  final List<Widget> _pages = [
    const HomeContentPage(),
    const BookmarkPage(),
    const TicketPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_outline), label: "Bookmark"),
          BottomNavigationBarItem(icon: Icon(Icons.airplane_ticket_outlined), label: "Ticket"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

// HomeContentPage contains the actual Home content with cards
class HomeContentPage extends StatelessWidget {
  const HomeContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Good Morning"),
            Text(
              "Tetteh Jeron Asiedu",
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_outlined),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 12),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notification_add_outlined),
            ),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(14),
        children: [
          // LOCATION CARD
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const LocationDetailsPage(locationName: "Galle Fort")),
              );
            },
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15)),
              child: const Center(child: Text("Location Card Placeholder")),
            ),
          ),
          const SizedBox(height: 15),

          // TOURIST PLACES
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const TouristPlaceDetailsPage(placeName: "Sigiriya Rock")),
              );
            },
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.orangeAccent.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15)),
              child: const Center(child: Text("Tourist Places Placeholder")),
            ),
          ),
          const SizedBox(height: 10),

          // Recommendation Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recommendation",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RecommendationPage()),
                    );
                  },
                  child: const Text("View All"))
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RecommendationPage()),
              );
            },
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                  color: Colors.greenAccent.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15)),
              child: const Center(child: Text("Recommended Places Placeholder")),
            ),
          ),
          const SizedBox(height: 10),

          // Nearby Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Nearby From You",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NearbyPlacesPage()),
                    );
                  },
                  child: const Text("View All"))
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NearbyPlacesPage()),
              );
            },
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                  color: Colors.purpleAccent.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15)),
              child: const Center(child: Text("Nearby Places Placeholder")),
            ),
          ),
        ],
      ),
    );
  }
}
